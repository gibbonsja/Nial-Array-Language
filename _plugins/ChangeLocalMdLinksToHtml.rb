module ChangeLocalMdLinksToHtml
  class Generator < Jekyll::Generator
    def generate(site)
      site.pages.each { |p|
        rewrite_links(site, p)
      }
    end
    
    def rewrite_links(site, page)
      # page.content = page.content.gsub(/(\[[^\]]*\]\([^:\)]*)\.md[^\)]*\)/, '\1.html)')
      page.content = page.content.gsub(/(\[[^\]]*\])\(([^\)]*)\)/) { | match |
        
        nlocal = $1

        # Split reference section into page and internal ref
        i = $2.index('#')
        if i != nil then
          npage = $2[0,i]
          nref = $2[i..-1]
        else
          npage = $2
          nref = ""
        end

        # Transform
        nref = nref.gsub('_', '-').downcase
        if npage.end_with?('.md') then
          npage = npage[0..-4]+'.html'
        end

        # Return
        "#{nlocal}(#{npage}#{nref})"
      }

    end

  end
end
