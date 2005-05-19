From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <d120d50005042810127b824d9f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 4/28/05, Yani Ioannou <yani.ioannou@gmail.com> wrote:
> On 4/28/05, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > ...
> > err = sysfs_create_group_array(&i8k_device->dev.kobj, &i8k_fan_attr_array, num);
> >
> 
> Yes attribute groups would certainly aid bmcsensors in terms of
> getting rid of the static callbacks and replacing them with a few,
> however in using an array it still has the limitation that bmcsensors
> would have to set a limit on the number of sensors that it can see,
> and in doing so allocate space that likely will never be used (most
> ipmi bmcs have access to 10-40 sensors, but the odd few on high end
> servers from people I've been in contact with have at least 60, and so
> the current limit is 100).

Number of elements in an array is specified at creation time (3rd
argument to sysfs_create_group_array) so you do not have to set an
arbitrary limit. Interrogate your device during ->probe() and adjust
the limit accordingly.

Or maybe I still miss something?

-- 
Dmitry
