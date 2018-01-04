# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_blocks.rb


require 'helper'


class TestBlocks < MiniTest::Test


def test_blocks_with_hash

  b0 = Block.new( { from: "Vicent",  to: "Anne",    amount: 3 },
                  { from: "Anne",    to: "Julia",   amount: 2 },
                  { from: "Julia",   to: "Luuk",    amount: 1 } )

  b1 = Block.new( { from: "Vincent", to: "Max",     amount: 3 },
                  { from: "Anne",    to: "Martijn", amount: 2 },
                  { from: "Ruben",   to: "Julia",   amount: 1 } )

  blockchain = [b0,b1]

  ledger = Ledger.new( blockchain )

  pp ledger

  balances = {"Vicent"=>-3,
              "Anne"=>-1,
              "Julia"=>2,
              "Luuk"=>1,
              "Vincent"=>-3,
              "Max"=>3,
              "Martijn"=>2,
              "Ruben"=>-1}
  assert_equal balances, ledger.addr
end


def test_blocks_with_tx_v1

  b0 = Block.new( Tx.new( from: "Vicent",  to: "Anne",    amount: 3 ),
                  Tx.new( from: "Anne",    to: "Julia",   amount: 2 ),
                  Tx.new( from: "Julia",   to: "Luuk",    amount: 1 ))

  b1 = Block.new( Tx.new( from: "Vincent", to: "Max",     amount: 3 ),
                  Tx.new( from: "Anne",    to: "Martijn", amount: 2 ),
                  Tx.new( from: "Ruben",   to: "Julia",   amount: 1 ))

  blockchain = [b0,b1]

  ledger = Ledger.new( blockchain )

  pp ledger

  balances = {"Vicent"=>-3,
              "Anne"=>-1,
              "Julia"=>2,
              "Luuk"=>1,
              "Vincent"=>-3,
              "Max"=>3,
              "Martijn"=>2,
              "Ruben"=>-1}
  assert_equal balances, ledger.addr
end


def test_blocks_with_tx_v2

  b0 = Block.new( Tx.new( "Vicent",  "Anne",    3 ),
                  Tx.new( "Anne",    "Julia",   2 ),
                  Tx.new( "Julia",   "Luuk",    1 ))

  b1 = Block.new( Tx.new( "Vincent", "Max",     3 ),
                  Tx.new( "Anne",    "Martijn", 2 ),
                  Tx.new( "Ruben",   "Julia",   1 ))

  blockchain = [b0,b1]

  ledger = Ledger.new( blockchain )

  pp ledger

  balances = {"Vicent"=>-3,
              "Anne"=>-1,
              "Julia"=>2,
              "Luuk"=>1,
              "Vincent"=>-3,
              "Max"=>3,
              "Martijn"=>2,
              "Ruben"=>-1}
  assert_equal balances, ledger.addr
end


end  # class TestBlocks
