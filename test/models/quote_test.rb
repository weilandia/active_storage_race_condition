require 'test_helper'

class QuoteTest < ActiveSupport::TestCase
  def setup
    @quote = quotes(:one)
  end

  def attach(filename)
    file = file_fixture("attachments/#{filename}")

    @quote.attachments.attach(
      io: StringIO.new(file.read),
      filename: file.basename
    )
  end

  test "attaches attachment_flatfile" do
    attach("example_docx.docx")

    assert_equal 1, @quote.attachments.count
  end

  test "parse doc" do
    attach("example_doc.doc")

    assert_equal 1, @quote.attachments.count
  end

  test "parses docx" do
    attach("example_docx.docx")

    assert_equal 1, @quote.attachments.count
  end

  test "parses xlsx" do
    attach("example_xlsx.xlsx")

    assert_equal 1, @quote.attachments.count
  end

  test "parses xls" do
    attach("example_xls.xls")

    assert_equal 1, @quote.attachments.count
  end

  test "parses pdf" do
    attach("example_pdf.pdf")

    assert_equal 1, @quote.attachments.count
  end

  test "parses txt" do
    attach("example_txt.txt")

    assert_equal 1, @quote.attachments.count
  end

  test "does not parse odp" do
    attach("example_odp.odp")

    assert_equal 1, @quote.attachments.count
  end

  test "does not parse pptx" do
    attach("example_pptx.pptx")

    assert_equal 1, @quote.attachments.count
  end

  test "does not parse jpg" do
    attach("example_jpg.jpg")

    assert_equal 1, @quote.attachments.count
  end

  test "does not parse png" do
    attach("example_png.png")

    assert_equal 1, @quote.attachments.count
  end

  test "parses multiple attachments into single flatfile" do
    attach("example_docx.docx")
    attach("example_doc.doc")
    attach("example_xlsx.xlsx")
    attach("example_pdf.pdf")
    attach("example_txt.txt")

    assert_equal 5, @quote.attachments.count
  end
end
