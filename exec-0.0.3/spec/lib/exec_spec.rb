require 'exec'

describe Exec do
  subject { Exec }
  before do
    $stderr.stub! :puts
  end

  describe '#system' do
    context "with successful completion" do
      before { Exec.should_receive(:_system).once.and_return true }
      specify { Exec.system("true").should == true }
    end
    context "with non-zero exit code" do
      specify { Exec.system("false").should == 1 }
    end
    context "with unknown command" do
      specify { expect { Exec.system("afuiaerarhcfjk") }.should raise_error ::Exec::CommandNotFoundException }
    end
  end

  describe '#system_v' do
    it "prints the command" do
      $stderr.should_receive(:puts).with("true")
      Exec.system_v("true")
    end
    context "with successful completion" do
      specify { Exec.system("true").should == true }
    end
    context "with non-zero exit code" do
      specify { Exec.system_v("false").should == 1 }
    end
    context "with unknown command" do
      specify { expect { Exec.system_v("afuiaerarhcfjk") }.should raise_error ::Exec::CommandNotFoundException }
    end
  end

  describe '#system!' do
    context "with successful completion" do
      specify { Exec.system!("true").should == true }
    end
    context "with non-zero exit code" do
      specify { expect { Exec.system!("false") }.should raise_error ::Exec::NonZeroExitCodeException }
    end
    context "with unknown command" do
      specify { expect { Exec.system!("afguiauar") }.should raise_error ::Exec::CommandNotFoundException }
    end
  end

  describe '#system_v!#' do
    it "prints the command" do
      $stderr.should_receive(:puts).with("true")
      Exec.system_v!("true")
    end
    context "with successful completion" do
      specify { Exec.system_v!("true").should == true }
    end
    context "with non-zero exit code" do
      specify { expect { Exec.system_v!("false") }.should raise_error ::Exec::NonZeroExitCodeException }
    end
    context "with unknown command" do
      specify { expect { Exec.system!("asdfasdf") }.should raise_error ::Exec::CommandNotFoundException }
    end
    context "with rescue expression should catch the error" do
      specify { expect { Exec.system!("asdfasdf") rescue  nil }.should_not raise_error }
    end
  end
end

