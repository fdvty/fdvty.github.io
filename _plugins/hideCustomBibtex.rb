 module Jekyll
  module HideCustomBibtex
    def hideCustomBibtex(input)
      keywords = @context.registers[:site].config['filtered_bibtex_keywords'] || []

      cleaned = input.dup

      keywords.each do |keyword|
        cleaned = cleaned.gsub(/^.*#{Regexp.escape(keyword)}.*$\n?/, '')
      end

      cleaned = cleaned.lines.map do |line|
        next line unless line =~ /^\s*author\s*=/

        # Keep author markers in page rendering, but strip them in Bib popup text.
        line = line.gsub(/\\\(\s*\^\s*\{[^}]*\}\s*\\\)/, '')
        line = line.gsub(/\\dagger/, '')
        line = line.delete('#*')
        line = line.gsub(/\s+,/, ',')
        line.gsub(/\s{2,}/, ' ')
      end.join

      cleaned
    end
  end
end

Liquid::Template.register_filter(Jekyll::HideCustomBibtex)
