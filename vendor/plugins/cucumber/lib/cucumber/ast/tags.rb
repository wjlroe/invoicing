module Cucumber
  module Ast
    # Holds the names of tags parsed from a feature file:
    #
    #   @invoice @release_2
    #
    # This gets stored internally as <tt>["invoice", "release_2"]</tt>
    #
    class Tags #:nodoc:
      class << self
        EXCLUDE_PATTERN = /^~/

        def matches?(source_tag_names, tag_names)
          exclude_tag_names, include_tag_names = tag_names.partition{|tag_name| exclude_tag?(tag_name)}
          exclude_tag_names.map!{|name| name[1..-1]}
          !excluded?(source_tag_names, exclude_tag_names) && included?(source_tag_names, include_tag_names)
        end

        def exclude_tag?(tag_name)
          tag_name =~ EXCLUDE_PATTERN
        end
        
        private
        
        def excluded?(source_tag_names, query_tag_names)
          source_tag_names.any? && (source_tag_names & query_tag_names).any?
        end
        
        def included?(source_tag_names, query_tag_names)
          query_tag_names.empty? || (source_tag_names & query_tag_names).any?
        end
      end

      attr_reader :tag_names

      def initialize(line, tag_names)
        @line, @tag_names = line, tag_names
      end

      def accept(visitor)
        return if $cucumber_interrupted
        @tag_names.each do |tag_name|
          visitor.visit_tag_name(tag_name)
        end
      end

      def accept_hook?(hook)
        self.class.matches?(@tag_names, hook.tag_names)
      end

      def count(tag)
        # See discussion:
        # http://github.com/weplay/cucumber/commit/2dc592acdf3f7c1a0c333a8164649936bb82d983
        if @tag_names.respond_to?(:count) && @tag_names.method(:count).arity > 0
          @tag_names.count(tag) # 1.9
        else
          @tag_names.select{|t| t == tag}.length  # 1.8
        end
      end

      def to_sexp
        @tag_names.map{|tag_name| [:tag, tag_name]}
      end
    end
  end
end
