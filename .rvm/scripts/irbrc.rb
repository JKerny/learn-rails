# This is the common irbrc file used by all rvm ruby installations.
# This file will be overriden every time you update rvm.

# Turn on completion.
begin
  require "readline"

  require "irb/completion" rescue nil

  # Turn on history saving.
  # require "irb/ext/save-history"
  # IRB.conf[:HISTORY_FILE] = File.join(ENV["HOME"], ".irb-history")

  # Use an alternate way to on history saving until save-history is fixed.
  #
  #   bug:   http://redmine.ruby-lang.org/issues/show/1556
  #   patch: http://pastie.org/513500
  #
  # This technique was adopted from /etc/irbrc on OS X.
  histfile = File.expand_path(".irb-history", ENV["HOME"])

  if File.exist?(histfile)
    lines = IO.readlines(histfile).collect { |line| line.chomp }
    Readline::HISTORY.push(*lines)
  end

  Kernel::at_exit do
    maxhistsize = 100
    histfile = File::expand_path(".irb-history", ENV["HOME"])
    lines = Readline::HISTORY.to_a.reverse.uniq.reverse
    lines = lines[-maxhistsize, maxhistsize] if lines.compact.length > maxhistsize
    File::open(histfile, "w+") { |io| io.puts lines.join("\n") }
  end

rescue LoadError
  puts "Readline was unable to be required, if you need completion or history install readline then reinstall the ruby.\nYou may follow 'rvm notes' for dependencies and/or read the docs page https://rvm.io/packages/readline/ . Be sure you 'rvm remove X ; rvm install X' to re-compile your ruby with readline support after obtaining the readline libraries."
end

# Calculate the ruby string.
rvm_ruby_string = ENV["rvm_ruby_string"] ||
  (
    ENV['GEM_HOME'] &&
    ( path = ( File.realpath(ENV['GEM_HOME'].to_s) rescue nil ) ) &&
    ( path = $1 if path =~ /(.+)\/$/ ; true ) &&
    path.split(/\//).last.split(/@/).first
  ) ||
  ("#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}" rescue nil) ||
  (RUBY_DESCRIPTION.split(" ")[1].sub('p', '-p') rescue nil ) ||
  (`ruby -v` || '').split(" ")[1].sub('p', '-p')

# cut ruby- ... everyone knows it's ruby
rvm_ruby_string = $1 if rvm_ruby_string =~ /^ruby[- ](.*)/

# Set up the prompt to be RVM specific.
@prompt = {
  :PROMPT_I => "#{rvm_ruby_string} :%03n > ",  # default prompt
  :PROMPT_S => "#{rvm_ruby_string} :%03n%l> ", # known continuation
  :PROMPT_C => "#{rvm_ruby_string} :%03n > ",
  :PROMPT_N => "#{rvm_ruby_string} :%03n?> ", # unknown continuation
  :RETURN => " => %s \n",
  :AUTO_INDENT => true
}
IRB.conf[:PROMPT] ||= {}
IRB.conf[:PROMPT][:RVM] = @prompt
IRB.conf[:PROMPT_MODE] = :RVM if IRB.conf[:PROMPT_MODE] == :DEFAULT

# Load the user's irbrc file, if possible.
# Report any errors that occur.
begin
  load File.join(ENV["HOME"], ".irbrc") if File.exist?("#{ENV["HOME"]}/.irbrc")
rescue LoadError => load_error
  puts load_error
rescue => exception
  puts "Error : 'load #{ENV["HOME"]}/.irbrc' : #{exception.message}"
end
