package CMSSideBar::Plugin;

use utf8;
use strict;
use base qw(MT::Plugin);

sub _blog_extras_param {
my ( $cb, $app, $param, $tmpl ) = @_;

my $blog_id = $app->param('blog_id');
my $plugin = MT->component("CMSSideBar");
my $scope = "blog:".$blog_id;

my $temp = $plugin->get_config_value('sortentries_active',$scope) || 0;

$param->{ sortentries_active } = $temp; #=> <mt:var name="foo">
}

sub _blog_extras_source {
my ($eh, $app, $tmpl) = @_;

my $old = <<HERE;
<ul id="<mt:var name="scope_type">-wide-menu" class="menu-nav">
HERE
my $old = quotemeta($old);

my $new = <<HERE;
<MTInclude name="plugins/CMSSideBar/tmpl/sidepanel.txt">
<ul id="<mt:var name="scope_type">-wide-menu" class="menu-nav">
HERE

$$tmpl =~ s/$old/$new/;

}

##デバッグ、ログ出力用
sub doLog {
	require MT::App;
	my $app = MT::App->new;
	my ($msg) = @_;
	return unless defined($msg);
	
	require MT::Log;
	my $log = MT::Log->new;
	$log->message($msg);
	$log->save or die $log->errstr;
}


1;