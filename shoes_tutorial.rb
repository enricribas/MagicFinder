Shoes.app :title => "New Finder", :width => 800 do
  exts = []
  files = []
  text = ""
  file_count = 0

  Dir.chdir(Dir.home + "/Documents")

  Dir['**/*'].each do |file|

    ext = File.extname(file) # skip the first letter
    if ext != ""
      exts << ext unless exts.include? ext
    end

    files << file unless File.directory?(file)
    file_count += 1 unless File.directory?(file)
  end

  files_list = nil
  number = nil

  flow do
    button "all" do
      all_files = ""
      file_count = 0
      Dir["**/*"].each do |file|
        all_files << file.to_s + "\n" unless File.directory?(file)
        file_count += 1 unless File.directory?(file)
      end
      files_list.replace all_files
      number.replace "File Count:" + file_count.to_s
    end

    exts.each do |ext|
      button ext do
        all_files = ""
        file_count = 0
        Dir["**/*#{ext}"].each do |file|
          all_files << file.to_s + "\n"
          file_count += 1 unless File.directory?(file)
        end
        files_list.replace all_files
        number.replace "File Count:" + file_count.to_s
      end
    end

    number = banner "File Count:" + file_count.to_s
    number.style :stroke => red, :size => 16
  end

  stack do
    files.each do |file|
      text << file.to_s + "\n"
    end
    files_list = para text
  end
end

