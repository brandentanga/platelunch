#!/usr/bin/env ruby
raw_data = `git log --since=1.day --shortstat | findstr "files changed"`
@insertions, @deletions, @commits = 0, 0, 0

puts 'testing'

def stats_for_today(raw_data)
  raw_data.scan(/changed, (\d+)/).each do |num|
    @insertions += num[0].to_i
    @commits += 1
  end
  raw_data.scan(/(\d+) deletions/).each do |num|
    @deletions += num[0].to_i
  end
  puts "stats for today"
  puts "number of commits: #{@commits}"
  puts "number of insertions: #{@insertions}"
  puts "number of deletions: #{@deletions}"
  puts "insertions + deletions == #{@insertions + @deletions}"
end

case ARGV[0]
when "stats_for_today"
  puts raw_data
  stats_for_today raw_data
when "raw_data"
  puts raw_data
else
  puts "Command not recognized. No plate lunch for you."
  puts "Usage: stats_for_today raw_data"
end
