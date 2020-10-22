require 'json'
require 'httparty'

module Claw
  # Autograder HTTParty Client Wrapper
  class Autograder
    include HTTParty
    base_uri 'autograder.io'

    def initialize(token, query = {})
      @options = {
        headers: {
          'Accept' => 'application/json, text/plain, */*',
          'Authorization' => "Token #{token}",
          'Cookie' => "token=#{token}"
        },
        query: query,
        verify: false
      }
    end

    def download_groups(projectid)
      puts 'Downloading groups json file (this could take a while)...'
      File.open(File.join(Dir.pwd, "project_#{projectid}_groups.json"), 'w') do |f|
        f.write(self.class.get("/api/projects/#{projectid}/groups/", @options))
      end
    end

    def get_group_id_from_uniqname(projectid, name)
      puts 'Searching for user group id...'
      download_groups(projectid) unless File.exist? "project_#{projectid}_groups.json"

      groups_json = JSON.parse(File.read(File.join(Dir.pwd, "project_#{projectid}_groups.json")))

      groups_json.each do |group|
        return group['pk'] if group['member_names'].include?(name)
      end

      nil
    end

    def submissions(groupid)
      puts 'Fetching group submissions...'
      self.class.get("/api/groups/#{groupid}/submissions/", @options)
    end

    def download_files(dirname, submission)
      puts 'Downloading submission files...'
      FileUtils.mkdir_p(File.join(Dir.pwd, dirname))

      submission['submitted_filenames'].each do |filename|
        opt_merge = {
          query: {
            'filename' => filename
          }
        }

        File.open(File.join(Dir.pwd, dirname, filename), 'w') do |f|
          f.write(self.class.get("/api/submissions/#{submission['pk']}/file/", @options.merge(opt_merge)))
        end
      end
    end
  end
end
