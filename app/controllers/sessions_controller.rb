class SessionsController < ApplicationController
  def new
  end

  def create
    auth = request.env['omniauth.auth']
    if auth.present?
      user = User.find_or_create_form_auth(request.env['omniauth.auth'])
      session[:user_id] = user.uid
      flash[:success] = "ユーザー認証が完了しました。"
      redirect_to root_path
    else
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        flash[:success] = "ログインしました!"
        redirect_back_or user
      else
        message  = " アカウントが有効になっていません "
        message += "登録されているEメールアドレスに届いたアクティベーション用のリンクを使用して、アカウントを有効化してください"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Eメールアドレスまたはパスワードが間違っています'
      render 'new'
    end
  end
end

  def destroy #reset_session でもOK?
    log_out
    flash[:danger] = 'ログアウトされました！'
    redirect_to root_url
  end

  def new_guest
    user = User.find_or_create_by(email: "guest@exapmle.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
      user.activated = true
    end
      session[:user_id] = user.id
      flash[:success] = "ゲストユーザーとしてログインしました"
      redirect_back_or root_url
  end
end
