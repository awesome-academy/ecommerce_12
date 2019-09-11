module CategoriesHelper
  def load_menu
    html = ""
    Category.cate_root.each do |cate_parent|
      html << build_category(cate_parent)
    end
    html
  end

  def build_category category
    html = ""
    categories_chil = category.childrens
    if categories_chil.present?
      html << "<li class='dropdown-submenu list-group-item'>"
      html << link_to(category.name, category)
      html << "<ul class='dropdown-menu'>"
      categories_chil.each do |cate|
        html << build_category(cate)
      end
      html << "</ul>"
      html << "</li>"
    else
      html << content_tag(:li, link_to(category.name, category),
        class: "list-group-item")
    end
    html
  end
end
