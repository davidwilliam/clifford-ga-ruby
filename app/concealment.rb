module Clifford
  class Concealment

    def self.csec_forward(k,m)
      k[0].gp(m).plus(m.gp(k[1]))
    end

    def self.csec_backward(k,c)
      k2_sum_k2_cc = k[1].plus(k[1].cc)
      k1_inverse_gp_k2 = k[0].inverse.gp(k[1])
      k1_inverse_gp_k2_gp_k2_cc = k1_inverse_gp_k2.gp(k[1].cc)
      left_side = k2_sum_k2_cc.plus(k1_inverse_gp_k2_gp_k2_cc).plus(k[0])
      right_side = k[0].inverse.gp(c).gp(k[1].cc).plus(c)
      left_side.inverse.gp(right_side)
    end

    def self.mc_forward(k,m)
      r = Clifford::Tools.generate_random_modular_multivector
      r.gp(k[0]).gp(k[1]).plus(m)
    end

    def self.mc_backward(k,c)
      Clifford::Tools.mod(c,k[0].gp(k[1]))
    end
  end
end
