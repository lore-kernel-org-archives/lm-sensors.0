From: linux@rick.claranet.de (Hartmut Rick)
Date: Wed, 08 Mar 2006 22:36:54 +0000
Subject: [lm-sensors]  Memory usage of sysfs files
Message-Id: <Pine.LNX.4.63.0603082311220.3051@Laila>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Hi everybody,

On Wed, 8 Mar 2006, Jean Delvare wrote:

> The only data I am missing now is the memory used by each additional
> sysfs file we create. We need to know, as Hans objected that too many
> sysfs files could have a negative impact on memory consumption. I dug

I've just created a couple sysfs files in order to find out, and the 
conclusion is that each additional sysfs file reduces the remaining free 
memory by something on the order of 90-95 bytes.
It turns out that the memory reported by 'free' varies quite a bit between 
calls, which disturbs somewhat the precision of this measurement. I had to 
create 10000 sysfs files in order to get a statistically significant 
result. Now this result is correct on the 10% level, which I think is good 
enough for our discussion.
For this experiment, I used the same callback function for all sysfs 
files, so each additional file has just one SENSOR_DEVICE_ATTR struct 
definition and a device_create_file() call, but no extra supporting code.
This is the typical situation for the individual alarm files, I guess.

With current DRAM prices, 100 extra bytes correspond to extra costs of 
around 1e-5 EUR or USD for each additional file, which I think is 
tolerable.

Best regards,
  Hartmut

