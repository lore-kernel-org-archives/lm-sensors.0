From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH] i2c-ipmi, i2c-ipmb: fix compilation with openipmi.sf.net
Message-Id: <427935B5.2090202@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050501162737.GC2589@procyon.home>
In-Reply-To: <20050501162737.GC2589@procyon.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

checked in to CVS
thanks
mds

Yani Ioannou wrote:
> On 5/1/05, Sergey Vlasov <vsu@altlinux.ru> wrote:
> 
>>Hello!
>>
>>http://openipmi.sourceforge.net/ provides patches for 2.4.x kernels
>>with updated IPMI code.  However, these patches change the IPMI driver
>>API by adding an additional argument to ipmi_request():
>>
>> int ipmi_request(ipmi_user_t      user,
>>                 struct ipmi_addr *addr,
>>                 long             msgid,
>>                 struct ipmi_msg  *msg,
>>+                void             *user_msg_data,
>>                 int              priority);
>>
>>(user_msg_data is later returned in the struct ipmi_recv_msg field).
>>This API change breaks compilation of some lm_sensors drivers
>>(i2c-ipmb, i2c-ipmi).
>>
>>The patch below adds compatibility with the new IPMI API to i2c-ipmb
>>and i2c-ipmi drivers.  <linux/ipmi.h> does not provide a real
>>API-version #define, therefore IPMI_RESPONSE_RESPONSE_TYPE (also added
>>by the openipmi.sf.net patch) is (ab)used as a new API indicator.
>>
>>Compile tested only due to lack of hardware.
>>
>>--- lm_sensors-2.8.4/kernel/busses/i2c-ipmi.c.ipmi-update       2003-03-17 04:39:57 +0300
>>+++ lm_sensors-2.8.4/kernel/busses/i2c-ipmi.c   2004-02-28 19:37:19 +0300
>>@@ -86,7 +86,11 @@
>>
>> static void ipmi_i2c_send_message(int id, struct ipmi_msg * msg)
>> {
>>+#ifdef IPMI_RESPONSE_RESPONSE_TYPE
>>+       ipmi_request(i2c_ipmi_user, &address, (long) id, msg, NULL, 0);
>>+#else
>>        ipmi_request(i2c_ipmi_user, &address, (long) id, msg, 0);
>>+#endif
>> }
>>
>> /* This is the message send function exported to the client
>>--- lm_sensors-2.8.4/kernel/busses/i2c-ipmb.c.ipmi-update       2003-03-17 04:39:57 +0300
>>+++ lm_sensors-2.8.4/kernel/busses/i2c-ipmb.c   2004-02-28 19:36:23 +0300
>>@@ -87,7 +87,12 @@
>> {
>>        int err;
>>
>>-       if((err = ipmi_request(i2c_ipmb_user, address, id, msg, 0)))
>>+#ifdef IPMI_RESPONSE_RESPONSE_TYPE
>>+       err = ipmi_request(i2c_ipmb_user, address, id, msg, NULL, 0);
>>+#else
>>+       err = ipmi_request(i2c_ipmb_user, address, id, msg, 0);
>>+#endif
>>+       if (err)
>>                printk(KERN_INFO "i2c-ipmb.o: ipmi_request error %d\n",
>>                        err);
>> }
>>
>>--
>>Sergey Vlasov
> 
> 
> Hi Sergey,
> 
> Actually there was a patch to the 2.6 i2c-ipmi/bmcsensors for this
> problem (after Bene Martin notified me of the problem and how to fix
> it), but from what I understand Corey re-included the ipmi_request
> method in the next version once he learned of a driver using it (it
> was removed because there was thought to be no usage). He was eager to
> learn when bmcsensors would make it into the kernel so that he could
> stop being nagged by the 'unused function police' as he put it ;-).
> 
> It might be wise to apply a patch like this in 2.4 to support the
> openipmi that went 'wrong', I changed the 2.6 driver to use the
> ipmi_request_settime function to no ill effect, but you should
> consider that Corey notes that it is preferred to use the old one:
> 
> (extract from some e-mail between Corey, Martin and I about the problem):
> 
> 
>>>>Interestingly enough the ipmi_request_settime still has a comment in
>>>>the header "Don't use this unless you *really* have to.", making me
>>>>wonder if there is a reason not to be using it instead of ipmi_request
>>>>if its re-incorporated into the kernel.
>>>>
>>>>
>>>
>>>I guess the only one qualified to answer that one would be corey.
>>>
>>>Bye, Martin
>>>
>>>
>>
>>You wouldn't generally use it because it sets the timeouts and for most
>>purposes the timeouts are defined by the spec (sort of).
>>
>>Do you have any feeling when the BMC sensors package will go into the
>>mainstream kernel?  That would be the time to coordinate adding the
>>normal function back in so I'm not constantly fighting the unused
>>function police.
>>
>>-Corey
> 
> 

