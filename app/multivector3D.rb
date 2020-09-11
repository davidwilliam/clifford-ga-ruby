module Clifford
  class Multivector3D
    attr_accessor :e0, :e1, :e2, :e3, :e12, :e13, :e23, :e123

    def initialize(input=[])

      if input.is_a?(Array) && input.size == 8 && input.map{|a| a.is_a?(Numeric)}.uniq == [true]
        @e0 = input[0]
        @e1 = input[1]
        @e2 = input[2]
        @e3 = input[3]
        @e12 = input[4]
        @e13 = input[5]
        @e23 = input[6]
        @e123 = input[7]
      else
        raise Multivector3DError, "Invalid input. Input must be an array of 8 numeric entries."
      end
    end

    def to_s
      "#{self.e0}e0 + #{self.e1}e1 + #{self.e2}e2 + #{self.e3}e3 + #{self.e12}e12 + #{self.e13}e13 + #{self.e23}e23 + #{self.e123}e123"
    end

    def inspect
      to_s
    end

    def geometric_product(m2)
      m = self.clone
      m.e0 = (self.e0*m2.e0) + (self.e1*m2.e1) + (self.e2*m2.e2) +
             (self.e3*m2.e3) - (self.e12*m2.e12) - (self.e13*m2.e13) -
             (self.e23*m2.e23) - (self.e123*m2.e123)
      m.e1 = (self.e0*m2.e1) + (self.e1*m2.e0) - (self.e2*m2.e12) -
             (self.e3*m2.e13) + (self.e12*m2.e2) + (self.e13*m2.e3) -
             (self.e23*m2.e123) - (self.e123*m2.e23)
      m.e2 = (self.e0*m2.e2) + (self.e1*m2.e12) + (self.e2*m2.e0) -
             (self.e3*m2.e23) - (self.e12*m2.e1) + (self.e13*m2.e123) +
             (self.e23*m2.e3) + (self.e123*m2.e13)
      m.e3 = (self.e0*m2.e3) + (self.e1*m2.e13) + (self.e2*m2.e23) +
             (self.e3*m2.e0) - (self.e12*m2.e123) - (self.e13*m2.e1) -
             (self.e23*m2.e2) - (self.e123*m2.e12)
      m.e12 = (self.e0*m2.e12) + (self.e1*m2.e2) - (self.e2*m2.e1) +
              (self.e3*m2.e123) + (self.e12*m2.e0) - (self.e13*m2.e23) +
              (self.e23*m2.e13) + (self.e123*m2.e3)
      m.e13 = (self.e0*m2.e13) + (self.e1*m2.e3) - (self.e2*m2.e123) -
              (self.e3*m2.e1) + (self.e12*m2.e23) + (self.e13*m2.e0) -
              (self.e23*m2.e12) - (self.e123*m2.e2)
      m.e23 = (self.e0*m2.e23) + (self.e1*m2.e123) + (self.e2*m2.e3) -
              (self.e3*m2.e2) - (self.e12*m2.e13) + (self.e13*m2.e12) +
              (self.e23*m2.e0) + (self.e123*m2.e1)
      m.e123 = (self.e0*m2.e123) + (self.e1*m2.e23) - (self.e2*m2.e13) +
               (self.e3*m2.e12) + (self.e12*m2.e3) - (self.e13*m2.e2) +
               (self.e23*m2.e1) + (self.e123*m2.e0)
      m
    end

    alias_method :gp, :geometric_product

    def clifford_conjugation
      m = self.clone
      m.e0 = self.e0
      m.e1 = -self.e1
      m.e2 = -self.e2
      m.e3 = -self.e3
      m.e12 = -self.e12
      m.e13 = -self.e13
      m.e23 = -self.e23
      m.e123 = self.e123
      m
    end

    alias_method :cc, :clifford_conjugation

    def reverse
      m = self.clone
      m.e0 = self.e0
      m.e1 = self.e1
      m.e2 = self.e2
      m.e3 = self.e3
      m.e12 = -self.e12
      m.e13 = -self.e13
      m.e23 = -self.e23
      m.e123 = -self.e123
      m
    end

    def star
      m = self.clone
      m.e0 = self.e0
      m.e1 = -self.e1
      m.e2 = -self.e2
      m.e3 = -self.e3
      m.e12 = self.e12
      m.e13 = self.e13
      m.e23 = self.e23
      m.e123 = -self.e123
      m
    end

    def reduction
      m = self.clone
      m.e0 = self.e0
      m.e1 = self.e1
      m.e2 = self.e2
      m.e3 = -self.e3
      m.e12 = self.e12
      m.e13 = -self.e13
      m.e23 = -self.e23
      m.e123 = -self.e123
      m
    end

    def amplitude_squared
      self.gp(self.cc)
    end

    def rationalize
      self.amplitude_squared.gp(amplitude_squared.reverse)
    end

    def scalar_div(scalar)
      m = self.clone
      m.e0 = Rational(self.e0,scalar)
      m.e1 = Rational(self.e1,scalar)
      m.e2 = Rational(self.e2,scalar)
      m.e3 = Rational(self.e3,scalar)
      m.e12 = Rational(self.e12,scalar)
      m.e13 = Rational(self.e13,scalar)
      m.e23 = Rational(self.e23,scalar)
      m.e123 = Rational(self.e123,scalar)
      m
    end

    def scalar_mul(scalar)
      m = self.clone
      m.e0 = self.e0 * scalar
      m.e1 = self.e1 * scalar
      m.e2 = self.e2 * scalar
      m.e3 = self.e3 * scalar
      m.e12 = self.e12 * scalar
      m.e13 = self.e13 * scalar
      m.e23 = self.e23 * scalar
      m.e123 = self.e123 * scalar
      m
    end

    def plus(m2)
      m = self.clone
      m.e0 = self.e0 + m2.e0
      m.e1 = self.e1 + m2.e1
      m.e2 = self.e2 + m2.e2
      m.e3 = self.e3 + m2.e3
      m.e12 = self.e12 + m2.e12
      m.e13 = self.e13 + m2.e13
      m.e23 = self.e23 + m2.e23
      m.e123 = self.e123 + m2.e123
      m
    end

    def minus(m2)
      m = self.clone
      m.e0 = self.e0 - m2.e0
      m.e1 = self.e1 - m2.e1
      m.e2 = self.e2 - m2.e2
      m.e3 = self.e3 - m2.e3
      m.e12 = self.e12 - m2.e12
      m.e13 = self.e13 - m2.e13
      m.e23 = self.e23 - m2.e23
      m.e123 = self.e123 - m2.e123
      m
    end

    def inverse
      numerator = self.cc.gp(self.amplitude_squared.reverse)
      denominator = self.rationalize.e0

      numerator.scalar_div(denominator)
    end

    def data
      [e0,e1,e2,e3,e12,e13,e23,e123]
    end

    def complex
      self.gp(self.cc)
    end

    def z
      self.plus(self.cc).scalar_div(2)
    end

    def f
      self.minus(self.cc).scalar_div(2)
    end

    def z2
      z.gp(z)
    end

    def f2
      f.gp(f)
    end

    def eigenvalues
      [
        Complex(z.e0,z.e123) + Math.sqrt(Complex(f2.e0,f2.e123)),
        Complex(z.e0,z.e123) - Math.sqrt(Complex(f2.e0,f2.e123)),
      ]
    end

  end
end
