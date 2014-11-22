module Mutant
  module AST
    # Groups of node types
    module Types
      symbolset = ->(strings) { strings.map(&:to_sym).to_set.freeze }

      ASSIGNABLE_VARIABLES = symbolset.(%w[ivasgn lvasgn cvasgn gvasgn])

      INDEX_ASSIGN_OPERATOR = :[]=

      # Set of nodes that cannot be on the LHS of an assignment
      NOT_ASSIGNABLE         = symbolset.(%w[int float str dstr class module self nil])

      # Set of op-assign types
      OP_ASSIGN              = symbolset.(%w[or_asgn and_asgn op_asgn])
      # Set of node types that are not valid when emitted standalone
      NOT_STANDALONE         = symbolset.(%w[splat restarg block_pass])
      INDEX_OPERATORS        = symbolset.(%w[[] []=])
      UNARY_METHOD_OPERATORS = symbolset.(%w[~@ +@ -@ !])

      # Operators ruby implements as methods
      METHOD_OPERATORS = symbolset.(%w[
        <=> === []= [] <= >= == !~ != =~ <<
        >> ** * % / | ^ & < > + - ~@ +@ -@ !
      ])

      BINARY_METHOD_OPERATORS = symbolset.(
        METHOD_OPERATORS - (INDEX_OPERATORS + UNARY_METHOD_OPERATORS)
      )

      OPERATOR_METHODS = symbolset.(
        METHOD_OPERATORS + INDEX_OPERATORS + UNARY_METHOD_OPERATORS
      )

      # Nodes that are NOT handled by mutant.
      #
      # not - 1.8 only, mutant does not support 1.8
      #
      BLACKLIST = symbolset.(%w[not])

      # Nodes that are NOT generated by parser but used by mutant / unparser.
      EXTRA = symbolset.(%w[empty])

      # Nodes that are currently missing from parser META
      MISSING = symbolset.(%w[rational])

      # All node types mutant handles
      ALL = symbolset.((Parser::Meta::NODE_TYPES + EXTRA + MISSING) - BLACKLIST)
    end # Types
  end # AST
end # Mutant
