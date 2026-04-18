class Web::UsersController < Web::ApplicationController
  before_action :find_and_authorize_user, except: %i[new create index]

  def index
    authorize User

    @q = policy_scope(User).default_order.ransack(params[:q])
    @users_cnt = @q.result.count

    @pagy, @users = pagy(@q.result)

    @main_title = 'Пользователи'
    set_user_breadcrumbs
  end

  def show
    set_user_breadcrumbs({ title: @user.email, path: user_path(@user) })
  end

  def new
    authorize User

    @user = User.new

    set_user_breadcrumbs({ title: 'Новый пользователь' })
  end

  def edit
    set_user_breadcrumbs({ title: @user.email, path: user_path(@user) })
  end

  def create
    authorize User

    @user = User.new(user_params)

    if @user.save
      flash[:notice] = 'Пользователь успешно создан'
      redirect_to user_path(@user)
    else
      set_user_breadcrumbs({ title: 'Новый пользователь' })
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Пользователь отредактирован' if @user.saved_changes?
      redirect_to user_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.discard
    flash[:alert] = 'Пользователь удалён'
    redirect_to user_path(@user)
  end

  def restore
    @user.undiscard!
    flash[:notice] = 'Пользователь восстановлен'
    redirect_to user_path(@user)
  end

  def lock
    @user.lock_access!(send_instructions: false)
    flash[:notice] = 'Пользователь заблокирован'
    redirect_to user_path(@user)
  end

  def unlock
    @user.unlock_access!
    flash[:notice] = 'Пользователь разблокирован'
    redirect_to user_path(@user)
  end

  private

  def find_and_authorize_user
    @user = User.find(params[:id])
    authorize @user
  end

  def user_params
    attrs = %i[username email password role]
    attrs << :password_confirmation if action_name == 'create'

    permitted = params.expect(user: attrs)
    permitted.delete(:password) if permitted[:password].blank?
    permitted
  end

  def set_user_breadcrumbs(additional = nil)
    @breadcrumbs = [
      { title: 'Пользователи', path: users_path }
    ]
    @breadcrumbs << additional if additional
  end
end
