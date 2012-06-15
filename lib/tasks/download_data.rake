require 'mechanize'
require 'fileutils'

ZIP_FILE_PATH = 'tmp/download_data/nppes_data.zip'

desc "Download latest NPPES Data File"
task :download do

  agent = Mechanize.new
  file  = agent.get('http://nppes.viva-it.com/NPI_Files.html').link_with(:href => /\.zip\z/).click

  FileUtils.mkdir_p File.dirname(ZIP_FILE_PATH)
  file.save(ZIP_FILE_PATH)
end

desc "Unzip the latest NPPES Data File"
task :unzip do
  `unzip #{ZIP_FILE_PATH} -d #{File.dirname(ZIP_FILE_PATH)}`
end

desc "Download and Process."
task :download_and_process => [:environment, :download, :unzip] do
  file = Dir.glob("#{File.dirname(ZIP_FILE_PATH)}*.csv").reject{|name| name =~ /Header/}.first
  Rake::Task['populate_nppes'].invoke(file)
end