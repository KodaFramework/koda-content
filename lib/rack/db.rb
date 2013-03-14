module Koda
  class Db
    def initialize(app)
      @app = app

      db = MongoConfig::GetMongoDatabase()
      @db_wrapper = MongoDatabase.new db
      @grid_wrapper = MongoGrid.new(MongoConfig::GetGridFS(), @db_wrapper.collection('_koda_meta'))
    end

    def call(env)
      env['koda_db'] = @db_wrapper
      env['koda_db_grid'] = @grid_wrapper
      @app.call(env)
    end
  end
end