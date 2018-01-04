# encoding: utf-8

require 'pp'            # for pp => pretty printer
require 'forwardable'
require 'date'
require 'time'
require 'json'




## our own code
require 'ledger-lite/version'    # note: let version always go first



module LedgerLite

class Ledger
  extend Forwardable


  attr_reader :addr     ## make addr private e.g. remove - why? e.g. use hash forwards/delegates - why not?

  ## delegate some methods (and operators) to addr hash (for easier/shortcut access)
  def_delegators :@addr, :[], :size, :each, :empty?, :any?


  def initialize( *args )
    @addr = {}

     ## add all transactions passed in on startup; if no args - do nothing
     unless args.empty?
       ## note: MUST unsplat (*) args
       ##   otherwise args get "double" wrapped in array
       write( *args )
     end
  end # method initialize



  def write( *args )
    puts "write:"
    pp args

    ##  note: allow/support splat-* for now for convenience (auto-wraps args into array)
    if args.size == 1 && args[0].is_a?( Array )
      puts " unwrap array in array"
      blks_or_txns = args[0]   ## "unwrap" array in array
    else
      blks_or_txns = args      ## use "auto-wrapped" splat array
    end

    ## "unpack" transactions from possible (optional) blocks
    ##   and return "flattend" **single** array of transactions
    transactions = unpack_transactions( blks_or_txns )

    ## unpack & unsplat array (to pass in args to send) => from, to, amount
    transactions.each { |tx| send( *unpack(tx) ) }
  end

  ## note: add and the << operator is an alias for write
  alias :add :write
  alias :<<  :write


  def unpack_transactions( blocks )
    ## "unpack" transactions from possible (optional) blocks
    ##   and return "flattend" **single** array of transactions

    blocks.reduce( [] ) do |acc, block|
      if block.respond_to?( :transactions )   ## bingo! assume it's block if it has transactions method
        acc + block.transactions
      else   ## note: otherwise assumes it's just a "plain" **single** transaction
        tx = block
        acc + [tx]    ## wrap in array (use acc << tx  - with side effects/mutate in place - why? why not?)
      end
    end
  end

  def unpack( tx )
    ## "unpack" from, to, amount values

    puts "unpack:"
    pp tx

    if tx.is_a?( Hash )   ## support hashes
      from   = tx[:from]
      to     = tx[:to]
      amount = tx[:amount]
    else   ## assume it's a transaction (tx) struct/class
      from   = tx.from
      to     = tx.to
      amount = tx.amount
    end
    [from,to,amount]
  end


  ##
  # find a better name - why? why not?
  ##  e.g. use can? funds? sufficient? has_funds?
  def sufficient_funds?( addr, amount )
    ## fix:
    true
  end


  ## apply/do single transaction - send payment - do transfer
  ##  - find a different name - why? why not?
  def send( from, to, amount )

    if sufficient_funds?( from, amount )
      @addr[ from ] ||= 0
      @addr[ from ] -= amount
      @addr[ to ] ||= 0
      @addr[ to ] += amount
    end
  end  # method transfer

  ## note: transfer is an alias for send (payment)
  alias :transfer :send


end # class Ledger

end # module LedgerLite


###
# add convenience top-level shortcut / alias
Ledger = LedgerLite::Ledger

# say hello
puts LedgerLite.banner    if defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG
