# coding: utf-8
# Bildschirm-Ausgabe
#
# Beispiel:
#
# require './lib/logger'
# $log = Log.new
# $log.filter_out( "my_secret_password" ) # dieses Passwort niemals ausgeben!
# $log.head("Mein tolles Programm")
# $log.section("Überschrift")
# $log.info("Einfache Meldung")
# $log.success("Erfolgsmeldung")
# $log.warning("Warnung")
# $log.error("Fehlermeldung")
# $log.prompt("Ausgabe eines Systembefehls")
require 'colored'
STDOUT.sync = true
class Log
  def head( text )
    info ""
    info "==========================================================".blue
    info text.blue
    info "==========================================================".blue
  end
  def section( heading )
    info ""
    info heading.blue
    info "----------------------------------------------------------".blue
  end
  def info( text )
    self.write text
  end
  def success( text )
    self.write text.green
  end
  def error( text )
    self.write text.red
  end
  def warning( text )
    self.write "Warning: ".yellow.bold + text.yellow
  end
  def prompt( text )
    self.write "$ " + text.bold
  end
  def write( text )
    @filter_out ||= []
    @filter_out.each do |expression|
      text = text.gsub(expression, "[...]")
    end
    print text + "\n"
  end
  def filter_out( expression )
    @filter_out ||= []
    @filter_out << expression
  end
  def filter( expression )
    filter_out expression
  end
end

def log
  $log ||= Log.new
end
