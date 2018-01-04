## $:.unshift(File.dirname(__FILE__))

## minitest setup

require 'minitest/autorun'


## our own code

require 'ledger-lite'



## some helper classes for testing

class Transaction

  attr_reader :from, :to, :amount

  #####
  # flexible for testing - allows:
  #  Tx.new( 'Alice', 'Bob', 12 )
  #  Tx.new( from: 'Alice', to: 'Bob', amount: 12 )

  def initialize( *args, **kwargs )
    if args.empty? # try keyword args
      @from   = kwargs[:from]
      @to     = kwargs[:to]
      @amount = kwargs[:amount]
    else           # try positional args
      @from   = args[0]
      @to     = args[1]
      @amount = args[2]
    end
  end

end # class Transaction

Tx = Transaction  ## convenience shortcut


class Block
  def initialize( *transactions )
    @transactions = transactions
  end

  def transactions
    @transactions
  end
end  # class Block
