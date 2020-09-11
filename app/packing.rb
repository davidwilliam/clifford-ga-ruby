module Clifford
  class Packing

    def self.a
      Clifford::Multivector3D.new [170, 146, 138, 255, 141, 162, 170, 211]
    end

    def self.g
      65536
    end

    # m_10 here refers to a message m in base 10
    def self.cep_forward(m_10)
      d = Clifford::Multivector3D.new [0] * 8
      r = Clifford::Tools.random_number(8)

      d.e0 = Rational(r + m_10,2)
      d.e2 = Rational(r - m_10,2)

      m = a.gp(d).gp(a.inverse)

      m
    end

    def self.cep_backward(m)
      m.eigenvalues.last
    end

    def self.cep_backward_2(m)
      d = a.inverse.gp(m).gp(a)
      d.e0 - d.e2
    end

    def self.cmsp_forward(m_10)

      error = true

      while error
        bit_size = m_10.bit_length

        m = Clifford::Multivector3D.new [0,0] + Array.new(6){ Clifford::Tools.random_number(bit_size) }

        a = Clifford::Tools.random_number(bit_size)
        b = (m_10 - a**2)**Rational(1,2)

        t = b**2 - 4*b*m.e2*m.e13 + 4*b*m.e3*m.e12 + 4*m.e2**2*m.e13**2 + 4*m.e2**2*m.e23**2
        u = -4*m.e2**2*m.e123**2 - 8*m.e2*m.e3*m.e12*m.e13 + 4*m.e3**2*m.e12**2 + 4*m.e3**2*m.e23**2 - 4*m.e3**2*m.e123**2
        v = -4*m.e12**2*m.e23**2 + 4*m.e12**2*m.e123**2 - 4*m.e13**2*m.e23**2 + 4*m.e13**2*m.e123**2 - 4*m.e23**4
        w = 8*m.e23**2*m.e123**2 + 4*a*m.e23**2 - 4*m.e123**4 - 4*a*m.e123**2

        x1 = (b - 2*m.e2*m.e13 + 2*m.e3*m.e12)/(2*m.e123).to_r
        x2 = (m.e23)
        x3 = (b*m.e23)
        x4 = m.e123
        x5 = (t + u + v + w)
        x6 = (-2*m.e2*m.e13*m.e23 + 2*m.e3*m.e12*m.e23)
        x7 = (2*m.e123) * (m.e23 + m.e123) * (m.e23 - m.e123)
        x8 = 2 * (m.e23 + m.e123) * (m.e23 - m.e123)

        # m.e0 = (x1 - (x2 * (x3 + x4 * x5**(0.5) + x6)) / x7)
        m.e0 = x1 - (x2 * (x3 + x4 * Math.sqrt(x5) + x6)) / x7.to_r
        # m.e1 = (-(x3 + x4 * x5**(0.5) + x6) / x8)
        m.e1 = -(x3 + x4 * Math.sqrt(x5) + x6) / x8.to_r

        begin
          cmsp_backward(m)
          error = false
        rescue => e
        end
      end

      m
    end

    def self.cmsp_backward(m)
      m.rationalize.e0.real.round % g
    end
  end
end
