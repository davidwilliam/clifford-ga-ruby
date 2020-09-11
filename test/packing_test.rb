require "minitest/autorun"

require Dir.pwd + "/boot"

class TestPacking < Minitest::Test

  def test_cep
    m_10 = 23

    m = Clifford::Packing.cep_forward(m_10)

    assert_equal m_10, Clifford::Packing.cep_backward(m)
  end

  def test_addition_cep
    m1_10 = 36
    m2_10 = 85

    m1 = Clifford::Packing.cep_forward(m1_10)
    m2 = Clifford::Packing.cep_forward(m2_10)

    assert_equal m1_10 + m2_10, Clifford::Packing.cep_backward(m1.plus(m2))
  end

  def test_multiplication_cep
    m1_10 = 73
    m2_10 = 22

    m1 = Clifford::Packing.cep_forward(m1_10)
    m2 = Clifford::Packing.cep_forward(m2_10)

    assert_equal m1_10 * m2_10, Clifford::Packing.cep_backward(m1.gp(m2))
  end

  def test_cep_alternative
    m_10 = 23

    m = Clifford::Packing.cep_forward(m_10)

    assert_equal m_10, Clifford::Packing.cep_backward_2(m)
  end

  def test_cmsp
    m_10 = 28

    m = Clifford::Packing.cmsp_forward(m_10)

    assert_equal m_10, Clifford::Packing.cmsp_backward(m)
  end

  def test_multiplication_cmsp
    m1_10 = 54
    m2_10 = 32

    m1 = Clifford::Packing.cmsp_forward(m1_10)
    m2 = Clifford::Packing.cmsp_forward(m2_10)

    assert_equal m1_10 * m2_10, Clifford::Packing.cmsp_backward(m1.gp(m2))
  end

end
