require "minitest/autorun"

require Dir.pwd + "/boot"

class TestMultivector3D < Minitest::Test

  def test_initialization
    input = Array.new(8){ Clifford::Tools.random_number(8)}
    m = Clifford::Multivector3D.new input

    assert_equal Clifford::Multivector3D, m.class
    assert_equal input[0], m.e0
    assert_equal input[1], m.e1
    assert_equal input[2], m.e2
    assert_equal input[3], m.e3
    assert_equal input[4], m.e12
    assert_equal input[5], m.e13
    assert_equal input[6], m.e23
    assert_equal input[7], m.e123
  end

  def test_bad_initialization
    error1 = assert_raises(Multivector3DError) do
      m = Clifford::Multivector3D.new
    end

    error2 = assert_raises(Multivector3DError) do
      m = Clifford::Multivector3D.new []
    end

    error3 = assert_raises(Multivector3DError) do
      m = Clifford::Multivector3D.new 2
    end

    error4 = assert_raises(Multivector3DError) do
      m = Clifford::Multivector3D.new Array.new(7){ Clifford::Tools.random_number(8)}
    end

    expected_message = "Invalid input. Input must be an array of 8 numeric entries."

    assert_equal expected_message, error1.message
    assert_equal expected_message, error2.message
    assert_equal expected_message, error3.message
    assert_equal expected_message, error4.message
  end

  def test_to_s
    input = Array.new(8){ Clifford::Tools.random_number(8)}
    m = Clifford::Multivector3D.new input

    m_to_s = m.to_s
    expected_m_to_s = "#{input[0]}e0 + #{input[1]}e1 + #{input[2]}e2 + #{input[3]}e3 + #{input[4]}e12 + #{input[5]}e13 + #{input[6]}e23 + #{input[7]}e123"

    assert_equal expected_m_to_s, m_to_s
  end

  def test_data
    input = Array.new(8){ Clifford::Tools.random_number(8)}
    m = Clifford::Multivector3D.new input

    expected_data = input

    assert_equal expected_data, m.data
  end

  def test_geometric_product
    m = Clifford::Multivector3D.new [2,3,4,5,6,7,8,9]
    mm = m.gp(m)
    expected_multivector = Clifford::Multivector3D.new [-176,-132,142,-88,114,-44,86,88]

    assert_equal expected_multivector.data, mm.data
  end

  def test_clifford_conjugation
    input = Array.new(8){ Clifford::Tools.random_number(8)}
    m = Clifford::Multivector3D.new input

    input[1..6] = input[1..6].map{|a| a * (-1)}

    assert_equal input, m.cc.data
  end

  def test_reverse
    input = Array.new(8){ Clifford::Tools.random_number(8)}
    m = Clifford::Multivector3D.new input

    input[4..7] = input[4..7].map{|a| a * (-1)}

    assert_equal input, m.reverse.data
  end

  def test_amplitude_squared
    m = Clifford::Multivector3D.new [2,3,4,5,6,7,8,9]

    expected_multivector = Clifford::Multivector3D.new [22,0,0,0,0,0,0,-16]

    assert_equal expected_multivector.data, m.gp(m.cc).data
  end

  def test_rationalize
    m = Clifford::Multivector3D.new [2,3,4,5,6,7,8,9]

    assert_equal [740,0,0,0,0,0,0,0], m.rationalize.data
  end

  def test_scalar_div
    input = Array.new(8){ Clifford::Tools.random_number(8)}
    m = Clifford::Multivector3D.new input

    scalar = Clifford::Tools.random_number(5)

    expected_data = input.map{|a| Rational(a,scalar)}

    assert_equal expected_data, m.scalar_div(scalar).data
  end

  def test_scalar_mul
    input = Array.new(8){ Clifford::Tools.random_number(8)}
    m = Clifford::Multivector3D.new input

    scalar = Clifford::Tools.random_number(5)

    expected_data = input.map{|a| a * scalar}

    assert_equal expected_data, m.scalar_mul(scalar).data
  end

  def test_plus
    input1 = Array.new(8){ Clifford::Tools.random_number(8)}
    m1 = Clifford::Multivector3D.new input1

    input2 = Array.new(8){ Clifford::Tools.random_number(8)}
    m2 = Clifford::Multivector3D.new input2

    expected_data = input1.map.with_index{|a,i| a + input2[i]}

    assert_equal expected_data, m1.plus(m2).data
  end

  def test_minus
    input1 = Array.new(8){ Clifford::Tools.random_number(8)}
    m1 = Clifford::Multivector3D.new input1

    input2 = Array.new(8){ Clifford::Tools.random_number(8)}
    m2 = Clifford::Multivector3D.new input2

    expected_data = input1.map.with_index{|a,i| a - input2[i]}

    assert_equal expected_data, m1.minus(m2).data
  end

  def test_inverse
    m = nil

    while true
      input = Array.new(8){ Clifford::Tools.random_number(8)}
      m = Clifford::Multivector3D.new input
      break if m.rationalize.data.uniq != [0]
    end

    expected_data = [1] + [0] * 7

    assert_equal expected_data, m.gp(m.inverse).data
  end

  def test_z
    input = Array.new(8){ Clifford::Tools.random_number(8)}
    m = Clifford::Multivector3D.new input

    input[1..6] = [0] * 6

    assert_equal input, m.z.data
  end

  def test_f
    input = Array.new(8){ Clifford::Tools.random_number(8)}
    m = Clifford::Multivector3D.new input

    input[0] = 0
    input[7] = 0

    assert_equal input, m.f.data
  end

  def test_z_plus_f
    input = Array.new(8){ Clifford::Tools.random_number(8)}
    m = Clifford::Multivector3D.new input

    assert_equal m.data, m.z.plus(m.f).data
  end

  def test_f2
    input = Array.new(8){ Clifford::Tools.random_number(8)}
    m = Clifford::Multivector3D.new input

    assert_equal [0] * 6, m.f2.data[1..6]
  end

  def test_eigenvalues
    m = Clifford::Multivector3D.new [2,3,4,5,6,7,8,9]

    expected_data = [
      Complex(4.5323662175072155,19.26707741568027),
      Complex(-0.5323662175072155,-1.2670774156802675)
    ]

    assert_equal expected_data, m.eigenvalues
  end



end
