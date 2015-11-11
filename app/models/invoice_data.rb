require "prawn/measurement_extensions"


class InvoiceData

  def self.build_table_cell(order)

    s = "<b>Låntagare:</b> " + order.user + "\n"
    s += "<b>Sökt arbete:</b> " + order.isbn_issn + "\n"
    unless order.message.empty?
      s += "<b>Meddelande (" + order.receiving_library_code + "):</b> " + order.message + "\n"
    end
    unless order.author.empty?
      s += order.author + "\n"
    end
    unless order.title.empty?
      s += order.title + "\n"
    end
    unless order.imprint.empty?
      s += order.imprint + "\n"
    end

    cell = Prawn::Table::Cell::Text.new( @pdf, [0,0], :content => s, :inline_format => true)

    return cell

  end

  def self.build_price_string(order)

    p = order.price.to_s + " kr"
    return p

  end

  def self.create_pdf(orders)

    @pdf = Prawn::Document.new :page_size=> 'A4', :margin=>[12.7.send(:mm), 10.send(:mm), 12.7.send(:mm), 10.send(:mm)]

    @pdf.text "Fakturaunderlag", :size=>24, :style=>:bold
    @pdf.move_down 3.send(:mm)

    @pdf.text "Göteborgs universitetsbibliotek, " + orders[0].sigel, :size=>14, :style=>:bold
    @pdf.move_down 10.send(:mm)

    @pdf.text orders[0].receiving_library_name + ' (' + orders[0].receiving_library_code + ')', :size=>12, :style=>:bold
    @pdf.text orders[0].receiving_library_department, :size=>12, :style=>:normal
    @pdf.text orders[0].receiving_library_address1, :size=>12, :style=>:normal
    @pdf.text orders[0].receiving_library_address2, :size=>12, :style=>:normal
    @pdf.text orders[0].receiving_library_address3, :size=>12, :style=>:normal
    @pdf.text orders[0].receiving_library_zip_code + ' ' + orders[0].receiving_library_city, :size=>12, :style=>:normal

    @pdf.move_down 10.send(:mm)
    @pdf.font_size = 10

    data = orders.map do |order|
      [
        order.lf_number,
        InvoiceData.build_table_cell(order),
        InvoiceData.build_price_string(order)
        #order.price
      ]
    end

    headers = ['Beställningsnr', 'Beställning', 'Pris']

    data.unshift(headers)

    @pdf.table data do

      row(0).font_style = :bold
      header = true

      cells.borders = [:bottom]

      cells.column(0).width = 40.send(:mm)
      cells.column(2).width = 20.send(:mm)

    end

    @pdf.render
  end
end
