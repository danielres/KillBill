class TextEvaluator

  def evaluate input = "", options = {}
    separator = options[ :separator ] || ' '
    context   = options[ :context ] || BasicObject
    text      = make_string_of input, separator
    context.instance_eval '"' + text + '"'
  end

  private

    def make_string_of input, separator
      Array( input ).join(separator) || ""
    end

end