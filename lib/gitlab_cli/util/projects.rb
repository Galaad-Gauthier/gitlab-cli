module GitlabCli
  module Util
    class Projects
      def self.get_all
        begin 
          response = Array.new
          per_page = 100
          page = 0
          # If we get `per_page` results per page then we keep going.
          # If we get less than that we're done.
          while response.length == page * per_page do
            page += 1
            url = "projects?page=%s&per_page=%s" % [page, per_page]
            page_data = GitlabCli::Util.rest "get", url
            response.concat JSON.parse(page_data)
          end 

        rescue Exception => e
          raise e

        else
          projects = response.map do |p|
            GitlabCli::Project.new(p['id'],p['name'],p['description'],p['default_branch'],p['public'],p['path'],p['path_with_namespace'],p['issues_enabled'],p['merge_requests_enabled'],p['wall_enabled'],p['wiki_enabled'],p['created_at'],p['owner'])
          end
        end
      end
    end
  end
end

