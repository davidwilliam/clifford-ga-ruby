require "minitest/autorun"

require Dir.pwd + "/boot"

class TestConcealment < Minitest::Test

  def test_csec
    k = Clifford::Tools.generate_regular_keys

    m1_10 = 34
    m1 = Clifford::Packing.cep_forward(m1_10)
    c1 = Clifford::Concealment.csec_forward(k,m1)

    m2_10 = 75
    m2 = Clifford::Packing.cmsp_forward(m2_10)
    c2 = Clifford::Concealment.csec_forward(k,m2)

    m1_recovered = Clifford::Concealment.csec_backward(k,c1)
    m2_recovered = Clifford::Concealment.csec_backward(k,c2)

    assert_equal m1_10, Clifford::Packing.cep_backward(m1_recovered)
    assert_equal m2_10, Clifford::Packing.cmsp_backward(m2_recovered)
  end

  def test_addition_csec
    k = Clifford::Tools.generate_regular_keys

    m1_10 = 48
    m1 = Clifford::Packing.cep_forward(m1_10)
    c1 = Clifford::Concealment.csec_forward(k,m1)

    m2_10 = 53
    m2 = Clifford::Packing.cep_forward(m2_10)
    c2 = Clifford::Concealment.csec_forward(k,m2)

    m1_plus_m2_recovered = Clifford::Concealment.csec_backward(k,c1.plus(c2))

    assert_equal m1_10 + m2_10, Clifford::Packing.cep_backward(m1_plus_m2_recovered)
  end

  def test_mc
    k = Clifford::Tools.generate_modular_keys

    m_10 = 47
    m = Clifford::Packing.cep_forward(m_10)
    c = Clifford::Concealment.mc_forward(k,m)

    m_recovered = Clifford::Concealment.mc_backward(k,c)

    assert_equal m_10, Clifford::Packing.cep_backward_2(m_recovered)
  end

  def test_addition_mc
    k = Clifford::Tools.generate_modular_keys

    m1_10 = 63
    m1 = Clifford::Packing.cep_forward(m1_10)
    c1 = Clifford::Concealment.mc_forward(k,m1)

    m2_10 = 58
    m2 = Clifford::Packing.cep_forward(m2_10)
    c2 = Clifford::Concealment.mc_forward(k,m2)

    m1_plus_m2_recovered = Clifford::Concealment.mc_backward(k,c1.plus(c2))

    assert_equal m1_10 + m2_10, Clifford::Packing.cep_backward(m1_plus_m2_recovered)
  end

  def test_addition_mc
    k = Clifford::Tools.generate_modular_keys

    m1_10 = 63
    m1 = Clifford::Packing.cep_forward(m1_10)
    c1 = Clifford::Concealment.mc_forward(k,m1)

    m2_10 = 58
    m2 = Clifford::Packing.cep_forward(m2_10)
    c2 = Clifford::Concealment.mc_forward(k,m2)

    m1_plus_m2_recovered = Clifford::Concealment.mc_backward(k,c1.plus(c2))

    assert_equal m1_10 + m2_10, Clifford::Packing.cep_backward(m1_plus_m2_recovered)
  end

  def test_multiplication_mc
    k = Clifford::Tools.generate_modular_keys

    m1_10 = 63
    m1 = Clifford::Packing.cep_forward(m1_10)
    c1 = Clifford::Concealment.mc_forward(k,m1)

    m2_10 = 58
    m2 = Clifford::Packing.cep_forward(m2_10)
    c2 = Clifford::Concealment.mc_forward(k,m2)

    m1_times_m2_recovered = Clifford::Concealment.mc_backward(k,c1.gp(c2))

    assert_equal m1_10 * m2_10, Clifford::Packing.cep_backward(m1_times_m2_recovered)
  end

end
