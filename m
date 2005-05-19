From: rindjon@yahoo.com (Ron Rindzunski)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: struct i2c_adapter
Message-Id: <20050313095755.65690.qmail@web30809.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi !
trying to port my own application using i2c 2.6.1 interface version to i2c 2.9.0 version i got two compile errors, both referring to changes been done in struct i2c_adapter in i2c.h file:
problem # 1:
struct i2c_adapter {
-    struct semaphore lock; 
      was replaced by    
+   struct semaphore bus;
+   struct semaphore list;
problem # 2:
-    int client_count;
     has been deleted completely
}
 
can you please explain to me what were those fields original intention, why did you apply the changes, and most important - what should i do in order to overcome the problems resulting from those changes.
 
thanks
Ron
rindjon@yahoo.com  



		
---------------------------------
Do you Yahoo!?
 Yahoo! Mail - You care about security. So do we.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050313/47501b6f/attachment.html
