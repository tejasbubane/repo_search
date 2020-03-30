require_relative '../spec_helper.rb'

describe 'Repo Search Application' do
  let(:repos) do
    {
      items: [
        {
          full_name: 'rails/rails',
          owner: { avatar_url: 'http://example.com/rails.png' },
          description: 'Official codebase for rails'
        },
        {
          full_name: 'rails/rails-starter-kit',
          owner: { avatar_url: 'http://example.com/rails-starter-kit.png' },
          description: 'Basic starter kit for rails'
        }
      ]
    }
  end


  it 'renders search form' do
    get '/'

    expect(last_response).to be_ok
    expect(last_response.body).to include('searchbox')
  end

  it 'renders all repos by search query' do
    expect_any_instance_of(Octokit::Client)
      .to receive(:search_repositories)
      .with('rails').and_return(repos)

    post '/search', query: 'rails'
    expect(last_response).to be_ok
    expect(last_response.body).to include('Official codebase for rails')
    expect(last_response.body).to include('Basic starter kit for rails')
  end
end
