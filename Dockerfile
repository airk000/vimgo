FROM golang:1.5-alpine
RUN apk add --no-cache bash gawk sed grep bc coreutils vim git ctags

RUN git clone https://github.com/airk000/vimrc.git ~/.vim_runtime
RUN chmod +x ~/.vim_runtime/install_awesome_vimrc.sh
RUN sh ~/.vim_runtime/install_awesome_vimrc.sh

WORKDIR /root

RUN mkdir -p .vim/bundle
RUN git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
RUN cp /root/data/vimrc /root/.vimrc
RUN vim +PluginInstall +qall

ENTRYPOINT ["bash"]
