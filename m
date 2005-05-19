From: yanii@utsc.utoronto.ca (Yani Ioannou)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [Fwd: PATCH: bmcsensors and i2c-ipmi port to 2.6]
Message-Id: <405DDBC6.5080406@utsc.utoronto.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <4056FCE9.2020904@utsc.utoronto.ca>
In-Reply-To: <4056FCE9.2020904@utsc.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Yes, just to clarify I was referring to the sysfs_ops as defined in 
sysfs.h (and described in Documentation/filesystems/sysfs.txt).

struct sysfs_ops {
        ssize_t (*show)(struct kobject *, struct attribute *,char *);
	ssize_t (*store)(struct kobject *,struct attribute *,const char *);
};


However subsystems such as device.h are free to define their own 
implementations, as also described in 
Documentation/filesystems/sysfs.txt as an example, device.h defines

	ssize_t (*show)(struct device * dev, char * buf);
	ssize_t (*store)(struct device * dev, const char * buf);

and maps to the sysfs callbacks by the following code:

static ssize_t
dev_attr_show(struct kobject * kobj, struct attribute * attr, char * buf)
{
         struct device_attribute * dev_attr = to_dev_attr(attr);
         struct device * dev = to_dev(kobj);
         ssize_t ret = 0;
 
         if (dev_attr->show)
                 ret = dev_attr->show(dev,buf);
         return ret;
}

So the main problem for people writing sensors is that for some reason 
in the device.h implementation of the sysfs callbacks the attribute 
parameter was removed, I can only think there is a good reason for this 
(does anybody know why?). I suppose one method might be to implement our 
own set of callbacks for i2c - but because of the kobject hierarchy (as 
far as I can see - I could be wrong) we need to go through the device 
implementation to create the proper sysfs directory structure.

Yani

Jean Delvare wrote:

>Greg,
>
>  
>
>>Yani Ioannou wrote:
>>
>>    
>>
>>>I can't imagine why
>>>the device sysfs callbacks don't pass information on the file they
>>>pertain to, like the base sysfs callbacks, I can only think there
>>>must be a good reason, or something I'm missing.
>>>      
>>>
>
>See how I am not the only one complaining about the lack of an
>additional parameter to i2c sysfs callback functions, that would let us
>have a single callback function for several similar sysfs entries, much
>like we were doing in 2.4.
>
>Now that Yani seems to pretend other (non-i2c) sysfs callback functions
>work that way, I am even more confused and really wonder why it was
>decided we would not be able to use that possibility.
>
>  
>
