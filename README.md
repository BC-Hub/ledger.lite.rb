# Ledger Lite (Ruby Edition)

ledger-lite library / gem - hyper ledger book for the distributed blockchain internet era; add your transactions one block at a time; transfer crypto(currencie)s and balance the accounts


* home  :: [github.com/openblockchains/ledger.lite.rb](https://github.com/openblockchains/ledger.lite.rb)
* bugs  :: [github.com/openblockchains/ledger.lite.rb/issues](https://github.com/openblockchains/ledger.lite.rb/issues)
* gem   :: [rubygems.org/gems/ledger-lite](https://rubygems.org/gems/ledger-lite)
* rdoc  :: [rubydoc.info/gems/ledger-lite](http://rubydoc.info/gems/ledger-lite)


## Usage

Let's add some transactions to the (hyper) ledger book:

| From                | To           |   $ |
|---------------------|--------------|----:|
| Keukenhof (†)       | Vincent      |  11 |
| Vincent             | Anne         |   3 |
| Anne                | Julia        |   2 |
| Julia               | Luuk         |   1 |
|                     |              |     |
| Dutchgrown (†)      | Ruben        |  11 |
| Vincent             | Max          |   3 |
| Ruben               | Julia        |   2 |
| Anne                | Martijn      |   1 |

(†): Mining Transaction - New Dutch Gulden ($) on the Market!



### Use `send` (send payment/transfer money)

```ruby

ledger = Ledger.new

ledger.send( "Keukenhof†",  "Vincent", 11 )
ledger.send( "Vincent",     "Anne",     3 )
ledger.send( "Anne",        "Julia",    2 )
ledger.send( "Julia",       "Luuk",     1 )

ledger.send( "Dutchgrown†", "Ruben",   11 )
ledger.send( "Vincent",     "Max",      3 )
ledger.send( "Ruben",       "Julia",    2 )
ledger.send( "Anne",        "Martijn",  1 )

pp ledger   ## pp = pretty print

```

resulting in

```
#<LedgerLite::Ledger
 @addr={
   "Vincent" => 5,
   "Anne"    => 0,
   "Julia"   => 3,
   "Luuk"    => 1,
   "Ruben"   => 9,
   "Max"     => 3,
   "Martijn" => 1}>
```

that is, the addr hash holds all addresses (addr) with the account balances
telling you who owns how much:

| Addr(ess)           | Balance $ |
|---------------------|----------:|
| Vincent             |         5 |
| Anne                |         0 |
| Julia               |         3 |
| Luuk                |         1 |
| Ruben               |         9 |
| Max                 |         3 |
| Martijn             |         1 |


### Use `write` to write / add transactions

Or use transaction (tx) classes/structs:

``` ruby
ledger = Ledger.new

ledger.write( Tx.new( "Keukenhof†",  "Vincent", 11 ))
ledger.write( Tx.new( "Vincent",     "Anne",     3 ))
ledger.write( Tx.new( "Anne",        "Julia",    2 ))
ledger.write( Tx.new( "Julia",       "Luuk",     1 ))

ledger.write( Tx.new( "Dutchgrown†", "Ruben",   11 ))
ledger.write( Tx.new( "Vincent",     "Max",      3 ))
ledger.write( Tx.new( "Ruben",       "Julia",    2 ))
ledger.write( Tx.new( "Anne",        "Martijn",  1 ))

pp ledger
```


Or pass in many transaction (Tx) classes/structs:

``` ruby
ledger = Ledger.new

ledger.write( Tx.new( "Keukenhof†",  "Vincent", 11 ),
              Tx.new( "Vincent",     "Anne",     3 ),
              Tx.new( "Anne",        "Julia",    2 ),
              Tx.new( "Julia",       "Luuk",     1 ))

ledger.write( Tx.new( "Dutchgrown†", "Ruben",   11 ),
              Tx.new( "Vincent",     "Max",      3 ),
              Tx.new( "Ruben",       "Julia",    2 ),
              Tx.new( "Anne",        "Martijn",  1 ))

pp ledger
```

Or use the operator `<<` alias for `write`:

```ruby
ledger = Ledger.new

ledger << Tx.new( "Keukenhof†",  "Vincent", 11 )
ledger << Tx.new( "Vincent",     "Anne",     3 )
ledger << Tx.new( "Anne",        "Julia",    2 )
ledger << Tx.new( "Julia",       "Luuk",     1 )

ledger << [Tx.new( "Dutchgrown†", "Ruben",   11 ),
           Tx.new( "Vincent",     "Max",      3 ),
           Tx.new( "Ruben",       "Julia",    2 ),
           Tx.new( "Anne",        "Martijn",  1 )]

pp ledger
```

Or use transaction hashes:

``` ruby
ledger = Ledger.new

ledger.write( { from: "Keukenhof†", to: "Vincent",  amount: 11 },
              { from: "Vincent",    to: "Anne",     amount:  3 },
              { from: "Anne",       to: "Julia",    amount:  2 },
              { from: "Julia",      to: "Luuk",     amount:  1 })

ledger.write( { from: "Dutchgrown†", to: "Ruben",   amount: 11 },
              { from: "Vincent",     to: "Max",     amount:  3 },
              { from: "Ruben",       to: "Julia",   amount:  2 },
              { from: "Anne",        to: "Martijn", amount:  1 })

pp ledger
```





## License

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The `ledger-lite` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.
