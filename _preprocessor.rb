require 'fileutils'
require 'yaml'
require 'json'
require 'logger'

class Preprocessor
  def initialize

    @content_directory = File.absolute_path('../tomecast-podcasts')

    p @content_directory
  end

  def start
    #copy over the imagefiles

    Dir.glob(@content_directory + '/*').each do |podcast_folder_path|
      if !File.directory?(podcast_folder_path)
        next
      end

      podcast_name = File.basename(podcast_folder_path)

      #copy podcast images
      dest_cover_path = File.absolute_path("./img/covers/")
      FileUtils.cp_r("#{@content_directory}/#{podcast_name}/cover.jpg", "#{dest_cover_path}/#{podcast_name}.jpg")

      #copy data files
      dest_data_path = File.absolute_path("./_data")
      FileUtils.cp_r("#{@content_directory}/#{podcast_name}/metadata.json", "#{dest_data_path}/#{podcast_name}.json")

      #preprocess the episodes and copy them over to the dest folder
      Dir.glob("#{@content_directory}/#{podcast_name}/*").each do |episode_filepath|
        if File.directory?(episode_filepath) || File.basename(episode_filepath) == 'cover.jpg' || File.basename(episode_filepath) == 'metadata.json'
            next
        end
        episode_filename = File.basename(episode_filepath,'.json')

        #parse the podcast json file.
        p episode_filepath
        episode_data = JSON.parse(File.read(episode_filepath,:external_encoding => 'utf-8'))


        #set additional jekyll data
        episode_data['layout'] = 'post'

        #write the episode_data to the destination path as yaml embedded in a md file
        dest_podcasts_path = File.absolute_path("./podcasts/#{podcast_name}/_posts/")
        FileUtils.mkdir_p(dest_podcasts_path) unless File.directory?(dest_podcasts_path)

        File.open("#{dest_podcasts_path}/#{episode_filename}.md", 'w') {|f|
          f.write episode_data.to_yaml
          f.write "---\n"
        }



      end


    end
  end

end

preprocessor = Preprocessor.new
preprocessor.start
