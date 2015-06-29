require "prawn/measurement_extensions"


class InvoiceData
  def self.create_pdf(orders)

    pdf = Prawn::Document.new :page_size=> 'A4', :margin=>[12.7.send(:mm), 10.send(:mm), 12.7.send(:mm), 10.send(:mm)]

    pdf.text "Fakturaunderlag", :size=>24, :style=>:bold
    pdf.move_down 20.send(:mm)

    pdf.text orders[0].receiving_library_name + ' (' + orders[0].receiving_library_code + ')', :size=>12, :style=>:bold

    pdf.move_down 10.send(:mm)
    pdf.font_size = 10

    data = orders.map do |order|
      [
        order.lf_number,
        order.title,
        order.processing_time,
        order.price

      ]
    end

    headers = ['Beställningsnr', 'Titel', 'Leverans', 'Pris']

    data.unshift(headers)

    pdf.table data do

      row(0).font_style = :bold
      header = true

      cells.borders = [:bottom]

      cells.column(0).width = 40.send(:mm)
      cells.column(2).width = 20.send(:mm)
      cells.column(3).width = 10.send(:mm)

    end

    pdf.render
  end
end
