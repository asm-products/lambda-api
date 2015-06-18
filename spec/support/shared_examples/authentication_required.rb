shared_examples 'authentication required' do |method, path, params = {}, headers = {}|
  it 'returns 401 if not authenticated' do
    sign_out
    send "#{method}_json", path, params, headers.except('Authorization')
    expect(response.code).to eq('401')
  end
end
