set :output, {:standard => nil}

every :saturday, :at => '8pm' do
  rake 'download_and_process'
end