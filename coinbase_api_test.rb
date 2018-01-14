require 'coinbase/wallet'
yasin_key = '3dGbEpBzQOHaLDGe'
yasin_secret= 'mReHBxAEKhyFSUAW1UId6EepPln4woaF'

dylan_key='9L7AcC36YjtXK2uJ'
dylan_secret='J1LRZnKvUieG0qu1NhABhIau5BJiBMfg'

david_key='sfrCS7UztUDl6aFF'
david_secret='IUp655suMx5nGOzWdI8wWHySGvZ5xWED'

yasin_client = Coinbase::Wallet::Client.new(api_key: yasin_key, api_secret: yasin_secret)
dylan_client = Coinbase::Wallet::Client.new(api_key: dylan_key, api_secret: dylan_secret)
david_client = Coinbase::Wallet::Client.new(api_key:  david_key, api_secret: david_secret)


david_eth_account.send_money(to: yasin_eth_account, amount:'0.001', currency='ETH')


eth_wallet.send({'to' => second_eth_address, 'amount' => '0.001', 'currency' => 'ETH'})
