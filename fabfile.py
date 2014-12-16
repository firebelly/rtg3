from fabric.api import env, run, local, put, cd

env.project_name = 'rtg3'
env.hosts = ['dev.reasontogive.com']
env.user = 'deployer'
env.group = 'staff'

env.path = '/var/www/%s' % env.project_name
env.stage = 'staging'
env.git_branch = 'master'

def production():
    env.hosts = ['www.reasontogive.com']
    env.git_branch = 'production'
    env.stage = 'production'
    env.path = '/var/www/%s' % env.project_name

def deploy():
    with cd(env.path):
        run('git pull origin %s' % env.git_branch)
        run('RAILS_ENV=%s rake assets:precompile' % env.stage)
        run('touch tmp/restart.txt')
