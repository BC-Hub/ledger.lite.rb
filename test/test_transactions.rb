# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_transactions.rb


require 'helper'


class TestTransactions < MiniTest::Test


def test_send

  ledger = Ledger.new

  ledger.send( "Vicent",  "Anne",    3 )
  ledger.send( "Anne",    "Julia",   2 )
  ledger.send( "Julia",   "Luuk",    1 )

  ledger.send( "Vincent", "Max",     3 )
  ledger.send( "Anne",    "Martijn", 2 )
  ledger.send( "Ruben",   "Julia",   1 )

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


def test_with_tx_v1

  ledger = Ledger.new

  ledger.write( Tx.new( "Vicent",  "Anne",    3 ))
  ledger.write( Tx.new( "Anne",    "Julia",   2 ))
  ledger.write( Tx.new( "Julia",   "Luuk",    1 ))

  ledger.write( Tx.new( "Vincent", "Max",     3 ))
  ledger.write( Tx.new( "Anne",    "Martijn", 2 ))
  ledger.write( Tx.new( "Ruben",   "Julia",   1 ))

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


def test_with_tx_v2

  ledger = Ledger.new

  ledger.write( Tx.new( "Vicent",  "Anne",    3 ),
                Tx.new( "Anne",    "Julia",   2 ),
                Tx.new( "Julia",   "Luuk",    1 ))

  ledger.write( Tx.new( "Vincent", "Max",     3 ),
                Tx.new( "Anne",    "Martijn", 2 ),
                Tx.new( "Ruben",   "Julia",   1 ))

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


def test_with_tx_v3

  ledger = Ledger.new

  ledger << Tx.new( "Vicent",  "Anne",    3 )
  ledger << Tx.new( "Anne",    "Julia",   2 )
  ledger << Tx.new( "Julia",   "Luuk",    1 )

  ledger << [Tx.new( "Vincent", "Max",     3 ),
             Tx.new( "Anne",    "Martijn", 2 ),
             Tx.new( "Ruben",   "Julia",   1 )]

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



def test_with_hash

  ledger = Ledger.new

  ledger.write( { from: "Vicent",  to: "Anne",  amount: 3 },
                { from: "Anne",    to: "Julia", amount: 2 },
                { from: "Julia",   to: "Luuk",  amount: 1 })

  ledger.write( { from: "Vincent", to: "Max",     amount: 3 },
                { from: "Anne",    to: "Martijn", amount: 2 },
                { from: "Ruben",   to: "Julia",   amount: 1 })

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


end  # class TestTransactions
