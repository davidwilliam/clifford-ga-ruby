require "minitest/autorun"

require Dir.pwd + "/boot"

class TestTools < Minitest::Test

  def test_mod
    m1_10 = 133
    m2_10 = 64

    m1 = Clifford::Packing.cep_forward(m1_10)
    m2 = Clifford::Packing.cep_forward(m2_10)

    m1_mod_m2 = Clifford::Tools.mod(m1,m2)

    assert_equal m1_10 % m2_10, Clifford::Packing.cep_backward(m1_mod_m2)
  end

  def test_generate_regular_keys
    k = Clifford::Tools.generate_regular_keys

    assert_equal [1,0], k[0].gp(k[0].inverse).data.uniq
    assert_equal [1,0], k[1].gp(k[1].inverse).data.uniq
  end

end
