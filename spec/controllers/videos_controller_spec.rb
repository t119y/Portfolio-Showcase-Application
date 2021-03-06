require 'rails_helper'
require 'spec_helper'
# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe VideosController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Video. As you add validations to Video, be sure to
  # adjust the attributes here as well.
  # let(:valid_attributes_video){
  #   {:title=>"project1_video1",:link=>"https://youtu.be/VIso9o3-D_Q"}
  # }
  
   let(:valid_user_1_attributes){
    {:email => "eric@eric.com", :password => "Ff123456", :password_confirmation => "Ff123456", :first_name => "Eric", :last_name => "Bechtold", :street => "Michael Street", :city => "Iowa City", :state => "Iowa", :zipcode => "12345", :phone => "1234567890"}
  }
  
  # let(:valid_user_2_attributes){
  #   {:email => "eric2@eric.com", :password => "Ff123456", :password_confirmation => "Ff123456", :first_name => "Eric", :last_name => "Bechtold", :street => "Michael Street", :city => "Iowa City", :state => "Iowa", :zipcode => "12345", :phone => "1234567890"}
  # }

  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # VideosController. Be sure to keep this updated too.
  # let(:valid_session) { {} }
  
  before(:each) do
    user1 = User.create valid_user_1_attributes
    group1 = Group.create(:name => "Group 1", :description => "First group created for eric")
    group2 = Group.create(:name => "Group 2", :description => "Second group created for eric")
    user1.groups << group1
    user1.groups << group2
    user1.save
    project1 = Proj.create(:name => "Project 1", :description => "First project created for eric")
    project2 = Proj.create(:name => "Project 2", :description => "Second project created for eric")
    project3 = Proj.create(:name => "Project 3", :description => "Third project created for eric")
    project4 = Proj.create(:name => "Project 4", :description => "Fourth project created for eric")
    user1.projs << project1
    user1.projs << project2
    user1.projs << project3
    user1.projs << project4
    project1.videos << Video.create(:title=>"project1_video1",:link=>"https://youtu.be/VIso9o3-D_Q")
    project1.videos << Video.create(:title=>"project1_video2",:link=>"http://techslides.com/demos/sample-videos/small.3gp")
  end

  describe "GET #index" do
    it "assigns the videos that belong to one paticular project as @videos" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      project1=user1.projs.find_by_name("Project 1")
      video=project1.videos
      get :index, {:project_id=>project1.id}
      expect(assigns(:videos)).to eq(video)
    end
  end
  
  describe "GET #show" do
    it "assigns the requested video as @video" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      project1=user1.projs.find_by_name("Project 1")
      video=project1.videos.find_by_title("project1_video1")
      get :show, {:id=> video.id}
      expect(assigns(:video)).to eq(video)
    end
    it "assigns the requested video not youtube as @video" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      project1=user1.projs.find_by_name("Project 1")
      video=project1.videos.find_by_title("project1_video2")
      get :show, {:id=> video.id}
      expect(assigns(:video)).to eq(video)
    end
  end

  describe "GET #new" do
    it "assigns a new video as @video" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      project1=user1.projs.find_by_name("Project 1")
      get :new, {:project_id=>project1.id}
      expect(assigns(:video)).to be_a_new(Video)
    end
  end

  describe "GET #edit" do
    it "assigns the requested video as @video" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      project1=user1.projs.find_by_name("Project 1")
      video = project1.videos.find_by_title("project1_video1")
      get :edit,{:id=>video.id}
      expect(assigns(:video)).to eq(video)
    end
  end

  describe "POST #create" do
     let(:update_attributes) { {
        'title' => 'project1_video1',
        'link' => 'https://youtu.be/64kKZzf0CQs',
        'project_id'=>'1'
    }}
    let(:update_attributes_1) { {
        'title' => 'project1_video1',
        'link' => 'https://youtu.be/0flcPwCMkRM',
        'project_id'=>'1'
    }}
    let(:video_params) { {
      'title' => 'project1_video_new',
      'link' => 'https://youtu.be/cx82MPooQVg'
    }}
    it "can create a new video for current project" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      project1=user1.projs.find_by_name("Project 1")
      post :create, {:video => update_attributes}
      expect(assigns(:video)).to be_a(Video)
    end
    it "cannot create a new video with a same link in the same project" do 
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      project1=user1.projs.find_by_name("Project 1")
      post :create, {:video => {:title => "project1_video2", :link => "https://youtu.be/VIso9o3-D_Q", :project_id=>project1.id}}
      expect(assigns(:video)).to be_a(Video)
    end
    it "can redirect_to video list after create a video" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      project1=user1.projs.find_by_name("Project 1")
      new_video=project1.videos.new(video_params)
      post :create, {:video => update_attributes_1}
      assert_redirected_to videos_path(:project_id=>project1.id)
      #expect(response).to render_template(["videos/new", "layouts/application"])
      # expect(controller.notice).to eq('Video was successfully created.')
    end
    it "cannot create a video with an invalid link" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      project1=user1.projs.find_by_name("Project 1")
      post :create, {:video => {:title => "project1_video3", :link => "2", :project_id=>project1.id}}
      expect(assigns(:video)).to be_a(Video)
    end
    it "cannot create a youtube video with an invalid uid" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      project1=user1.projs.find_by_name("Project 1")
      post :create, {:video => {:title => "project1_video3", :link => "https://youtu.be/VIso9", :project_id=>project1.id}}
      expect(assigns(:video)).to be_a(Video)
    end
  end

  describe "PUT #update" do
    # let(:new_attributes) { {
    #   'title' => 'project1_video1',
    #   'link' => 'https://youtu.be/VIso9o3-D_Q'
    # }}
    let(:update_attributes) { {
      'title' => 'project1_video1',
      'link' => 'https://youtu.be/VIso9o3-D_Q',
      'project_id'=>'1'
    }}
      let(:invaild_attributes) { {
      'title' => '',
      'link' => 'https://youtu.be/VIso9o3-D_F',
      'project_id'=>'1'
    }}
      let(:invaild_attributes_2) { {
      'title' => 'project1_video1',
      'link' => '2',
      'project_id'=>'1'
    }}
    let(:invaild_attributes_3) { {
      'title' => 'project1_video3',
      'link' => 'https://youtu.be/VIso9',
      'project_id'=>'1'
    }}
    it "can update a existing video" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      project1=user1.projs.find_by_name("Project 1")
      video =project1.videos.find_by_title('project1_video1')
      put :update, {:id => video.id, :video => update_attributes}
      video.reload
      expect(controller.notice).to eq('Video was successfully updated.')
    end
    it "cannot update a existing video" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      project1=user1.projs.find_by_name("Project 1")
      video =project1.videos.find_by_title('project1_video1')
      put :update, {:id => video.id, :video => invaild_attributes}
      video.reload
    end
    it "cannot update a video with an invalid link" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      project1=user1.projs.find_by_name("Project 1")
      video =project1.videos.find_by_title('project1_video1')
      put :update, {:id => video.id, :video => invaild_attributes_2}
      video.reload
    end
    it "cannot update a youtube video with an invalid uid" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      project1=user1.projs.find_by_name("Project 1")
      video =project1.videos.find_by_title('project1_video1')
      put :update, {:id => video.id, :video => invaild_attributes_3}
      video.reload
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested video" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      project1=user1.projs.find_by_name("Project 1")
      video =project1.videos.find_by_title("project1_video1")
      expect {
        delete :destroy, {:id=> video.id}
      }.to change(Video, :count).by(-1)
    end

    it "redirects to the videos list" do
      user1 = User.find_by_email("eric@eric.com")
      sign_in user1
      project1=user1.projs.find_by_name("Project 1")
      video =project1.videos.find_by_title("project1_video1")
      delete :destroy,  {:id=> video.id}
      expect(response).to redirect_to(videos_path(:project_id=>project1.id))
    end
  end

end