require('pg')

class Sqlrunner

  def Sqlrunner.run( sql, values = [] )  ## defaults 'value' to empty array if no 'value' argument passed

    begin                                ## try catch - begin, ensure & end - tries to capture all eventualities
      db = PG.connect({dbname: 'music_collection', host: 'localhost'})
      db.prepare('query', sql)
      result = db.exec_prepared('query', values)
    ensure
      db.close() if db != nil
    end
    return result
  end

end
