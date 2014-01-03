module Rails

  # CacheCache allow you to manage dynamically multiple groups of HTML5 manifests.
  #
  class CacheCache

    # Constructor
    #
    def initialize(options = {}, &block)
      @group = options.fetch(:group, :default)
      @spoor = "generated by cache_cache"
      @seed = options.fetch(:seed, "")

      @cache = { }
      @network = { }
      @fallback = { }

      self.configure(&block) if block_given?
    end

    # Configure
    #
    def configure(&block)
      instance_eval(&block)
    end

    # Get / Set an entry into the cache section of the manifest
    #
    def cache(entry = nil)
      @cache[@group] ||= []

      unless entry.nil?
        @cache[@group] << entry
      end

       @cache[@group].flatten
    end

    # Get / Set an entry into the network section of the manifest
    #
    def network(entry = nil)
      @network[@group] ||= []

      unless entry.nil?
        @network[@group] << entry
      end

      @network[@group].flatten
    end

    # Get / Set an entry into the fallback section of the manifest
    #
    def fallback(entry = nil)
      @fallback[@group] ||= []

      unless entry.nil?
        @fallback[@group] << entry
      end

      @fallback[@group].flatten
    end

    # Get the manifest
    #
    def manifest
      return self.generate
    end

    # Generate the manifest
    #
    def generate
      [
        'CACHE MANIFEST'  ,
        '# ' + self.spoor ,
        '# ' + self.seed  ,
        'CACHE:'          ,
        self.cache        ,
        'NETWORK:'        ,
        self.network      ,
        'FALLBACK:'       ,
        self.fallback     ,
      ].join("\n")
    end

    # Get / Set the current group
    #
    def group(group_name = nil)
      @group = group_name unless group_name.nil?
      @group
    end

    # Get the spoor of the manifest
    #
    def spoor(spoor_content = nil)
      @spoor = spoor_content unless spoor_content.nil?

      @spoor
    end

    # Get the seed of the manifest
    #
    def seed(new_seed = nil)
      @seed = new_seed unless new_seed.nil?

      @seed
    end

    # Get label
    #
    def label
      "cache_cache_#{@group}"
    end

    # Get label seed
    #
    def label_seed
      "cache_cache_seed_#{@group}"
    end

    # Get the manifest
    #
    def to_s
      self.manifest
    end
  end
end