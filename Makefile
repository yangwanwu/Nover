CC = gcc
CFLAGS = -O2 -g -Wall -lpthread -c -MMD

#=======>指定目录 冒号分隔多个目录
VPATH = ./config:./socket:./db:./redis
#==========>指定目录及模式
#vpath %.h ser:../headers



 object = main.o lock.o logic.o mq.o ThreadPool.o \
	  server_epoll.o server_socket.o socket_buffer.o server_config.o \
	  connpool.o db.o redis_conn_pool.o redis.o \


 deps = $(patsubst %.o,%.d,$(object))



 server : $(object)
	$(CC) -o server $(object) -lpthread -lhiredis -lmysqlclient


 $(object) : %.o : %.c
	$(CC)  $(CFLAGS) -o $@ $<

 -include $(deps)

 .PHONY : clean

 clean : 
	rm -f server *.o *.tmp *.d