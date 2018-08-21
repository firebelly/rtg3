from fabric.api import env, run, local, put, cd

env.project_name = 'rtg3'
env.hosts = ['dev.reasontogive.com']
env.user = 'firebelly'

env.shell = '/bin/bash -lic' # interactive shell to source .bashrc to init rbenv
env.path = '/home/firebelly/webapps/rtg3/%s' % env.project_name
env.stage = 'staging'
env.git_branch = 'master'

def production():
    env.hosts = ['www.reasontogive.com']
    env.stage = 'production'

def deploy(migrate='no',assets='no'):
    update()
    bundle()
    if migrate != 'no':
        migrate()
    if assets != 'no':
        compile_assets()
    clear_rails_cache()
    restart()

def update():
    with cd(env.path):
        run('git pull origin %s' % env.git_branch)

def migrate():
    with cd(env.path):
        run('RAILS_ENV=%s bin/rake db:migrate' % env.stage)

def compile_assets():
    with cd(env.path):
        run('RAILS_ENV=%s bin/rake assets:precompile' % env.stage)

def clear_rails_cache():
    with cd(env.path):
        run('RAILS_ENV=%s rake tmp:cache:clear' % env.stage)

def restart():
    with cd(env.path):
        run('touch tmp/restart.txt')

def bundle():
    with cd(env.path):
        run('bundle install')
