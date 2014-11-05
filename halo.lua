dofile("urlcode.lua")
dofile("table_show.lua")
JSON = (loadfile "JSON.lua")()

local url_count = 0
local tries = 0
local item_type = os.getenv('item_type')
local item_value = os.getenv('item_value')

local downloaded = {}
local addedtolist = {}

--exclude all the following urls:
downloaded["http://www.bungie.net/images/halo3stats/odst/difficulty/Easy.gif"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/difficulty/Heroic.gif"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/difficulty/Legendary.gif"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/difficulty/Normal.gif"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/0ADE10A4-8130-463c-ADA7-AAC37A83C5E9_1.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/3F4CB84B-3755-4ec9-8E1F-4647EDB4919B_1.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/3F4CB84B-3755-4ec9-8E1F-4647EDB4919B_2.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/3F4CB84B-3755-4ec9-8E1F-4647EDB4919B_3.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/3F4CB84B-3755-4ec9-8E1F-4647EDB4919B_4.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/56408337-CD30-442b-8742-7AA78FEDBC58.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/7E0F1655-0DB5-4e31-B8B9-FC593701C7C6_1.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/7E0F1655-0DB5-4e31-B8B9-FC593701C7C6_2.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/7E0F1655-0DB5-4e31-B8B9-FC593701C7C6_3.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/7E0F1655-0DB5-4e31-B8B9-FC593701C7C6_4.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/879B88CF-3936-4592-959B-7D6079A0B164_1.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/879B88CF-3936-4592-959B-7D6079A0B164_2.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/879B88CF-3936-4592-959B-7D6079A0B164_3.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/879B88CF-3936-4592-959B-7D6079A0B164_4.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/89A4A8A5-8A59-4a4f-87AB-DC75FE1FE1A8_1.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/89A4A8A5-8A59-4a4f-87AB-DC75FE1FE1A8_2.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/89A4A8A5-8A59-4a4f-87AB-DC75FE1FE1A8_3.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/89A4A8A5-8A59-4a4f-87AB-DC75FE1FE1A8_4.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/A3321EEC-F2D5-4701-A5A4-405F69349F19_1.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/A3321EEC-F2D5-4701-A5A4-405F69349F19_2.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/A3321EEC-F2D5-4701-A5A4-405F69349F19_3.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/A3321EEC-F2D5-4701-A5A4-405F69349F19_4.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/BB14499B-B7BD-480f-8CC4-F851389D9A53_1.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/BB14499B-B7BD-480f-8CC4-F851389D9A53_2.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/BB14499B-B7BD-480f-8CC4-F851389D9A53_3.png"] = true
downloaded["http://www.bungie.net/images/halo3stats/odst/firefight/png_med/BB14499B-B7BD-480f-8CC4-F851389D9A53_4.png"] = true
downloaded["http://www.bungie.net/images/News/Inline10/043010/hatersgonna.jpg"] = true
downloaded["http://halo.bungie.net/images/ads/vertical_banners/earth_03_web.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/forums/pagesubjectBackground.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareicons/downloadarrow.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/filmclips/assembly.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/filmclips/avalanche.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/filmclips/blackout.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/filmclips/coldstorage.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/filmclips/construct.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/filmclips/epitaph.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/filmclips/ghosttown.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/filmclips/isolation.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/filmclips/longshore.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/filmclips/narrows.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/filmclips/orbital.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/filmclips/sandbox.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/filmclips/sandtrap.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/filmclips/standoff.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/alpha_site.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/assembly.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/avalanche.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/blackout.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/citadel.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/coastal_highway.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/coldstorage.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/construct.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/cortana.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/crater.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/crater_night.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/crowsnest.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/floodgate.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/ghosttown.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/halo.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/heretic.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/highground.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/isolation.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/last_exit.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/longshore.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/mombasa_streets.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/narrows.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/nmpd_hq.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/oni_alpha_site.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/orbital.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/ratsnest.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/sandbox.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/sandtrap.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/security_zone.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/sierra117.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/snowbound.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/standoff.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/tayari_plaza.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/theark.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/thecovenant.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/thepit.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/thestorm.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/tsavohighway.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/uplift_reserve.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/valhalla.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/windward.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/gametypes/bomb.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/gametypes/flag.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/gametypes/infection.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/gametypes/juggernaut.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/gametypes/koth.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/gametypes/oddball.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/gametypes/territories.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/gametypes/vip.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/maps/assembly.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/maps/blackout.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/maps/coldstorage.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/maps/construct.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/maps/epitaph.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/maps/ghosttown.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/maps/guardian.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/maps/highground.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/maps/isolation.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/maps/last_resort.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/maps/longshore.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/maps/narrows.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/maps/orbital.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/maps/snowbound.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/maps/thepit.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/rendervideo_overlay.gif"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/alpha_site.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/avalanche.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/blackout.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/chasm_ten.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/coastal_highway.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/coldstorage.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/construct.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/crater.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/crater_night.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/data_hive.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/gametype_overlays/infection.gif"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/gametype_overlays/juggernaut.gif"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/gametype_overlays/koth.gif"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/gametype_overlays/territories.gif"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/ghosttown.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/isolation.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/kikowani_stn.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/kizingo_blvd.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/last_exit.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/longshore.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/mombasa_streets.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/narrows.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/nmpd_hq.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/oni_alpha_site.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/orbital.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/rally_night.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/rally_point.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/security_zone.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/standoff.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/tayari_plaza.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/uplift_reserve.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/windward.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/000c2cd5-c22e-4c21-9cf7-2e3c543e9a4e.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/020ad610-23b3-433f-a2c7-845167663a6f.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/04e7f469-9566-41ee-a8cb-263a7eb29a50.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/0bd30346-acfe-4345-88c7-9a8f7c244cf1.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/0ccfa6b5-e265-46db-853b-19b047d8cdeb.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/0cfb0764-1c89-43b7-8571-ed9793c283d0.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/1992b840-696a-4399-9c48-5c14665ecb7b.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/26fcd797-b6ac-4a1a-8c31-90cf5b9d9e7f.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/27dedc9c-a7a5-459a-8a95-86c40532078d.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/34b8f992-b9e7-40cd-83dd-dd8ae37935cb.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/4643c781-fa96-473d-8696-d117d22973ff.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/568c7982-4557-4dd3-9d74-14cfb2b82943.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/6c793c56-b1fd-4235-b8bc-78cf9c8f0a1c.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/6f38a749-ce10-41a6-a25c-9c69e73c1277.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/7f2e73fa-3f5e-4c40-9624-d5c66433c8ba.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/8484abcc-37db-4d07-ab99-e26043d47af8.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/9021d802-d46f-428d-b066-e8e29f90fe6b.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/92e7e54f-fd9b-4511-b301-e55b71e3fdc5.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/94dd7646-937c-4e04-a932-8e419dcedb61.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/a14cafe5-070e-404e-b1e0-daf07c6940c0.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/ac2a6431-7c91-4fcf-a59b-b45c740d2815.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/ad185e3c-4195-4774-8dc1-2f992e2270a6.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/aead8c16-6eea-42eb-98c7-4559a473deaa.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/b09de653-ebfa-47b3-a59a-5d75c482fe05.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/ba5a761f-b700-43ad-87de-9a094deb80b0.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/c6b0bf44-80c9-41e4-a8de-c7368e219e02.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/cc9b908d-b40c-4c98-a0cb-80a4b83ef3ff.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/cf3f4a9c-3a89-4b7a-8905-8016f221252b.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/d5928317-43c8-4e49-b1d1-38e57b15ace4.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/d967f797-4c43-4f98-adc7-461008074e6f.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/dc3cc154-21bf-48db-9836-389c101c7071.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/e1962524-be31-4a85-8cbc-e1cff5a05433.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/e2529801-6d0d-448b-ab3b-5b4b932558a8.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/ed0ee792-72f4-4212-b0eb-58014bc90bd5.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/f34a8e8f-e2b0-40dc-86c9-a24a6e161166.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/fe2f6461-2f8f-4070-8f98-60e67c31c283.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/link40.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/link60.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/0cfb0764-1c89-43b7-8571-ed9793c283d0.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/26fcd797-b6ac-4a1a-8c31-90cf5b9d9e7f.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/27dedc9c-a7a5-459a-8a95-86c40532078d.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/4643c781-fa96-473d-8696-d117d22973ff.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/568c7982-4557-4dd3-9d74-14cfb2b82943.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/6c793c56-b1fd-4235-b8bc-78cf9c8f0a1c.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/6f38a749-ce10-41a6-a25c-9c69e73c1277.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/8484abcc-37db-4d07-ab99-e26043d47af8.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/9021d802-d46f-428d-b066-e8e29f90fe6b.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/a14cafe5-070e-404e-b1e0-daf07c6940c0.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/ad185e3c-4195-4774-8dc1-2f992e2270a6.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/b09de653-ebfa-47b3-a59a-5d75c482fe05.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/cc9b908d-b40c-4c98-a0cb-80a4b83ef3ff.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/d5928317-43c8-4e49-b1d1-38e57b15ace4.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/dc3cc154-21bf-48db-9836-389c101c7071.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/e2529801-6d0d-448b-ab3b-5b4b932558a8.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/ed0ee792-72f4-4212-b0eb-58014bc90bd5.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/f34a8e8f-e2b0-40dc-86c9-a24a6e161166.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/link25.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/difficulty/Easy.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/difficulty/Heroic.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/difficulty/Legendary.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/difficulty/Normal.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/0ADE10A4-8130-463c-ADA7-AAC37A83C5E9_1.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/3F4CB84B-3755-4ec9-8E1F-4647EDB4919B_1.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/3F4CB84B-3755-4ec9-8E1F-4647EDB4919B_2.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/3F4CB84B-3755-4ec9-8E1F-4647EDB4919B_3.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/3F4CB84B-3755-4ec9-8E1F-4647EDB4919B_4.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/56408337-CD30-442b-8742-7AA78FEDBC58.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/7E0F1655-0DB5-4e31-B8B9-FC593701C7C6_1.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/7E0F1655-0DB5-4e31-B8B9-FC593701C7C6_2.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/7E0F1655-0DB5-4e31-B8B9-FC593701C7C6_3.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/7E0F1655-0DB5-4e31-B8B9-FC593701C7C6_4.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/879B88CF-3936-4592-959B-7D6079A0B164_1.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/879B88CF-3936-4592-959B-7D6079A0B164_2.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/879B88CF-3936-4592-959B-7D6079A0B164_3.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/879B88CF-3936-4592-959B-7D6079A0B164_4.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/89A4A8A5-8A59-4a4f-87AB-DC75FE1FE1A8_1.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/89A4A8A5-8A59-4a4f-87AB-DC75FE1FE1A8_2.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/89A4A8A5-8A59-4a4f-87AB-DC75FE1FE1A8_3.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/89A4A8A5-8A59-4a4f-87AB-DC75FE1FE1A8_4.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/A3321EEC-F2D5-4701-A5A4-405F69349F19_1.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/A3321EEC-F2D5-4701-A5A4-405F69349F19_2.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/A3321EEC-F2D5-4701-A5A4-405F69349F19_3.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/A3321EEC-F2D5-4701-A5A4-405F69349F19_4.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/BB14499B-B7BD-480f-8CC4-F851389D9A53_1.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/BB14499B-B7BD-480f-8CC4-F851389D9A53_2.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/BB14499B-B7BD-480f-8CC4-F851389D9A53_3.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/firefight/png_med/BB14499B-B7BD-480f-8CC4-F851389D9A53_4.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/models/buck/buck_1_2_0.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/models/dutch/dutch_0_1_1.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/029d6b30-2900-4438-bd32-dbe1998049ca.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/0ee7f6b4-2b7a-426c-8c0f-f8f67c5723cb.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/10e9e09d-3f19-47ce-bd55-ff26159a07a9.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/12006ec4-2905-416c-b19f-9ed90b6b12f1.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/14bcd3f5-37b5-495b-802f-939b03019dd7.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/14ed4eb1-4f10-439a-ba2b-e939a8ea4cd6.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/1da38d39-ea10-45e4-8175-6e4952b233f5.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/27ca03cc-ac65-459e-8761-bd03e2157b1b.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/2ddce5c3-c435-4dd4-aa41-caa6802453d7.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/2e382a07-99f6-47fc-b756-7dbb5287ddd5.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/30404bed-998b-4808-a699-f617c8ca5216.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/3c9a99d0-fa08-4dc5-b0cc-0b777675eeda.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/4390e141-0c51-4ad9-87c6-1fbedacc3e9a.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/444564aa-4cb9-4d81-9fae-95dd3d2915a5.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/4e290a72-cd2b-4abf-8a98-8e851264d8b7.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/516bea68-93cd-47ad-b9a9-3208f6a3f373.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/638b74e6-aa06-4229-bcda-c23ffa186a31.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/82d9b54a-e024-4170-98cf-2343bd2d5b1e.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/879ebafd-3bcc-45d0-8e1e-6cad34a2dad7.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/9327ee58-8ab8-4dab-ba6d-853520d146fb.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/9a210eea-b9a3-4124-9f01-b2592a55f222.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/9b3187bd-7660-4fee-9c0f-48869c1b8d06.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/9e4ee750-f711-4346-95e6-447ed90b8fd3.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/a385a27f-5fd9-422b-83b2-c872acca5a0a.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/ab93df13-cba8-4e24-aa5d-5463eb8fae40.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/af33862b-84bb-4000-afda-fe3f782f55c5.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/b27effb2-23d3-478b-99ca-9d95f61edcd3.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/b34e9b83-3474-46c5-b5e4-443660fdd8ab.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/coldamage.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/d8a9397a-3964-47c3-bc57-0e932b7c2dd1.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/d98ec09e-8836-4ddc-a477-fa932a078f47.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/de1d62a4-7ef8-43dd-813d-eb40ef1fee9e.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/e2ec40ef-e7b4-4c91-b3b3-ffc0bfa9714b.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/ebbc224e-31d8-4997-818e-4ced08208e13.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/ef1afc36-e8af-4be0-9839-08ddea456681.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/f911730b-8fe2-4709-a406-8f58a20df5fd.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/falldamage.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/sm_coldamage.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/sm_falldamage.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/ac47d3a8-e569-4497-914f-b08da6e262b2.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/e4b3f9b2-cda2-4cae-8094-c778e297c32a.gif"] = true
downloaded["http://halo.bungie.net/App_Themes/Main_Default/Main_Default.css"] = true
downloaded["http://halo.bungie.net/base_css/base.css?ver=2.0.4777.31696"] = true
downloaded["http://halo.bungie.net/base_css/content.css?ver=2.0.4777.31696"] = true
downloaded["http://halo.bungie.net/base_css/forums.css"] = true
downloaded["http://halo.bungie.net/base_css/images.css?ver=2.0.4777.31696"] = true
downloaded["http://halo.bungie.net/base_css/page_css/halo3GameStatsCampaign.css"] = true
downloaded["http://halo.bungie.net/base_css/page_css/halo3UserContentDetails.css"] = true
downloaded["http://halo.bungie.net/base_css/page_css/odstg.css"] = true
downloaded["http://halo.bungie.net/base_css/rad_bungie.css?ver=2.0.4777.31696"] = true
downloaded["http://halo.bungie.net/base_css/sprites/nav-icons.css"] = true
downloaded["http://halo.bungie.net/base_css/Stats.css"] = true
downloaded["http://halo.bungie.net/images/account/bg_notificationBar.png"] = true
downloaded["http://halo.bungie.net/images/account/bg_notificationBar2.png"] = true
downloaded["http://halo.bungie.net/images/Ads/F5GameViewerMouse.gif"] = true
downloaded["http://halo.bungie.net/images/ajax-loading-horizontal.gif"] = true
downloaded["http://halo.bungie.net/images/ajax-loading-vertical.gif"] = true
downloaded["http://halo.bungie.net/images/ajax-loading.gif"] = true
downloaded["http://halo.bungie.net/images/arrow.gif"] = true
downloaded["http://halo.bungie.net/images/base.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/agegatecancel.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/agegateconfirm.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/agegatedl.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/arrow_1.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/arrow_2.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/arrow_3.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/arrow_4.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/arrow_5.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/arrow_rss.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/bg_block_a_h3.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/bg_block_c.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/bg_block_c_h2.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/bg_block_d.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/bg_block_d_h2.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/bg_block_g.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/bg_h2.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/bg_list_i.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/bg_repeat2.png"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/bluebutton-left.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/bluebutton-right.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/bluebutton.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/bluering.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/btn_close.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/btn_next.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/btn_previous.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/btn_search.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/contentBg/blackgradient.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/contentBg/blueheader.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/contentBg/body_bg_flip.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/contentBg/body_bg_flip_sm.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/contentBg/boxD-back.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/contentBg/communityfilesgradient.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/contentBg/grid.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/contentBg/halo2statbg.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/contentBg/halo3statbg.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/contentBg/profile-card-back.png"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/contentBg/profile-link-arrow.png"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/contentBg/signupwords.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/contentBg/tableheadergradient.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/contentBg/vidgradient2.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/db_friends_offline_icon.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/db_friends_online_icon.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/db_message_icon.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/db_nofriends_icon.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/Dock/Close.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/Dock/Collapse.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/Dock/Custom.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/Dock/Expand.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/Dock/Pin.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/Dock/TitlebarH.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/Dock/Unpin.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/forums/addpollForum.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/forums/cancelForum.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/forums/editForum.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/forums/IconArchived.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/forums/IconBungie.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/forums/IconHot.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/forums/IconLocked.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/forums/IconNew.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/forums/IconOld.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/forums/IconPinLocked.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/forums/IconPinned.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/forums/PollBackground.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/Forums/PollBar.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/forums/previewForum.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/forums/quoteForum.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/forums/replyForum.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/forums/reportForum.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/forums/submitForum.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/forums/unleashninjas.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/halo2-identity-back.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/halo3-identity-back-orange.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/headers/filestabbanner.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/headers/headersidebar.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/headers/service_record_header2.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/headers/service_record_header_sidebar.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/headers/seventhcolumn.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/headers/signup_header.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/headers/tableheadergradient.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/infopopupback.png"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/less.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/btn_cancel.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/btn_edit.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/btn_moretokens.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/btn_next.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/btn_rate.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/btn_rate_flash.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/btn_report.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/btn_report_flash.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/btn_submit2.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/btn_submit2_flash.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/button.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/close.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/expandedarrows.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/helpicon.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/leftarrow.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/nextnext.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/plusminus.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/posts_button.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/prevprev.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/redeemminutes.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/rightarrow.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/tabnavigation/blank/100px.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/tabnavigation/blank/130px.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/tabnavigation/blank/160px.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/tabnavigation/blank/60px.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/linkBt/tabnavigation/blank/80px.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/logo_bungie_01.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/menubg-hover.png"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/menubg.png"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/messages/ok.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/messages/servicerecord.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/more.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/newicon_off.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/newicon_on.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/news/alltopnewsarrow.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/news/arrow.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/news/carousel-left.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/news/carousel-right.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/news/digg.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/news/discussion.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/news/expand_sm.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/news/halo3_news_header.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/news/insert_media_player_button.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/news/mediaplayergradient_high.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/news/newsbodyback.png"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/news/newsgradient.png"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/news/newsgradientspotlight.png"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/news/odst_news_header.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/news/permalink.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/news/topstorybodyback.png"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/odst-identity-back-green.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/online/comm-files-back.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/online/goldseptagon_small.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/online/halo3-box-back.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/online/hor-bar.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/online/medal-bar.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/online/odst-box-back.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/online/offseptagon_small.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/online/onlinestats.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/online/playlistbuttons.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/online/recentgames_next_big.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/online/recentgames_off.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/online/recentgames_off2.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/online/recentgames_previous_big.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/online/recentgamesdetailblock.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/online/secnav-topline.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/online/share_bg_normal.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/online/share_bg_pro.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/online/share_bg_trophy.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/online_rotator_arrow_blue_left.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/online_rotator_arrow_blue_right.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/online_rotator_pager_blue.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/page_indicator_dark.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/page_indicator_light.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/RadToolTip/Callouts.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/RadToolTip/Loading.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/RadToolTip/ToolTipSprites.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/RadToolTip/ToolTipVerticalSprites.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/search/bg_searchDrop.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/search/bungienetuser.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/search/downarrow.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/search/files.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/search/forums.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/search/groups.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/search/halo2.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/search/halo3.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/search/news.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/search/reach.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/search/searchbackground.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/search/searchbutton.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/selected.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/signup/consent.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/sprites/nav-icons.png"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/stats/bigbluebutton.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/stats/contain-header.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/stats/email.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/stats/facebook.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/stats/gamehistoryback.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/stats/getsilverlight.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/stats/h2optimatchforumbanner.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/stats/h2optimatchforumbutton.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/stats/h3betaforumbanner.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/stats/h3betaforumbutton.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/stats/minibargraph.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/stats/print.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/stats/rightcol-icons.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/stats/topfour-back.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/stats/twitter.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/themes/default/brandnav_bg1px2.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/themes/default/forums/filmclips.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/themes/default/forums/films.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/themes/default/forums/gamevariants.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/themes/default/forums/HeaderCrimson.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/themes/default/forums/HeaderHalo3.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/themes/default/forums/HeaderHalo3Beta.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/themes/default/forums/HeaderNewMombasa.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/themes/default/forums/HeaderODST.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/themes/default/forums/HeaderOptimatch.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/themes/default/forums/HeaderReach.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/themes/default/forums/HeaderReachBeta.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/themes/default/forums/HeadertheClassifieds.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/themes/default/forums/HeaderTheFlood.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/themes/default/forums/HeaderTheGallery.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/themes/default/forums/HeaderTheLibrary.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/themes/default/forums/HeaderTheMaw.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/themes/default/forums/HeaderTheNews.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/themes/default/forums/HeaderTheSeptagon.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/themes/default/forums/HeaderTheUnderground.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/themes/default/forums/HeaderTheVotingBooth.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/themes/default/forums/maps.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/themes/default/forums/screenshots.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/top_nav/bg_nav.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/top_nav/bg_nav_total.jpg"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/top_nav/btn_search.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/top_nav/icon_avatar_placeholder.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/top_nav/logo_bungie.png"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/top_nav/nav_SubMenuArrow.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/top_nav/nav_SubMenuArrowInverted.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/top_nav/sprite_mainNavIcons.png"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/top_nav/sprite_topNavHeadings.png"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/top_nav/subnavArrows.png"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/updateicon_co.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/updateicon_ib.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/updateicon_pr.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/updateicon_st.gif"] = true
downloaded["http://halo.bungie.net/images/base_struct_images/updateicon_su.gif"] = true
downloaded["http://halo.bungie.net/images/dancinggrunt.gif"] = true
downloaded["http://halo.bungie.net/images/dark/lower_neb.png"] = true
downloaded["http://halo.bungie.net/images/dark/ohmygodiseestars.gif"] = true
downloaded["http://halo.bungie.net/images/dark/upper_neb.png"] = true
downloaded["http://halo.bungie.net/images/Errors/webmaster.png"] = true
downloaded["http://halo.bungie.net/images/Games/Halo3/h3-project-back.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo2Stats/LevelBar.gif"] = true
downloaded["http://halo.bungie.net/images/halo2stats/stat_halo2banner.jpg"] = true
downloaded["http://halo.bungie.net/images/halo2stats/stat_halo2header.jpg"] = true
downloaded["http://halo.bungie.net/images/halo2stats/stat_halo3banner.jpg"] = true
downloaded["http://halo.bungie.net/images/halo2stats/stat_halo3header.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/achievements/achievement-header.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/arrowopen.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/background-fade.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/boxy-back-1.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/boxy-back-2.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/button-back.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/dark_grad_bg.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/dwn-arrow-wht.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareicons/bungiefavorite_icon.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareicons/downloadarrow_flash.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareicons/linkedfile_icon.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareicons/pro_icon.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareicons/reportedfile.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareicons/screenshots/overlay.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareicons/screenshots/screenshotnotfound_160.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareicons/screenshots/screenshots.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareicons/screenshots/trophy.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareicons/setfile_arrow.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/filmclips/citadel.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/filmclips/foundry.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/filmclips/guardian.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/filmclips/heretic.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/filmclips/highground.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/filmclips/last_resort.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/filmclips/ratsnest.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/filmclips/snowbound.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/filmclips/thepit.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/filmclips/valhalla.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/epitaph.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/foundry.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/guardian.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/last_resort.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/films/lost_platoon.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/gametypes/slayer.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/maps/avalanche.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/maps/citadel.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/maps/foundry.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/maps/heretic.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/maps/ratsnest.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/maps/sandbox.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/maps/sandtrap.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/maps/standoff.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/maps/valhalla.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/mini_icons/film.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/mini_icons/filmclip.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/mini_icons/gametype.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/mini_icons/map.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/mini_icons/rendered_film.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/mini_icons/screenshot.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/screenshots/screenshot.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/slots/1.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/slots/10.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/slots/11.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/slots/12.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/slots/13.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/slots/14.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/slots/15.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/slots/16.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/slots/17.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/slots/18.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/slots/19.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/slots/2.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/slots/20.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/slots/21.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/slots/22.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/slots/23.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/slots/24.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/slots/3.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/slots/4.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/slots/5.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/slots/6.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/slots/7.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/slots/8.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fileshareiconssm/slots/9.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/fpo/stripeybar.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/identity/no-halo3.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/identity/no-odst.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/identity/ranked.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/identity/social.png"] = true
downloaded["http://halo.bungie.net/images/halo3stats/mainblock-back.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/Assembly.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/Citadel.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/epitaph.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/foundry.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/gametype_overlays/bomb.gif"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/gametype_overlays/flag.gif"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/gametype_overlays/forge.gif"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/gametype_overlays/oddball.gif"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/gametype_overlays/slayer.gif"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/gametype_overlays/vip.gif"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/guardian.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/heretic.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/highground.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/lost_platoon.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/ratsnest.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/Sandbox.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/shrine.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/snowbound.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/the_pit.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/valhalla.jpg"] = true
downloaded["http://halo.bungie.net/images/Halo3Stats/Maps/largemaps/zanzibar.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/00cd185d-3484-40e6-9fda-486c8821a31c.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/03e9492b-4374-445b-b218-b8b17a6b72e8.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/0b308a47-9eff-40cc-8fe3-ca413f9cd6ed.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/0ca38e2c-e68f-4368-852e-4f121ec4d1ce.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/0e078a43-0a57-4236-9790-c98f620e07aa.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/1855facd-1c96-411c-ae82-712e45b6fec0.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/1a78d3dd-34b7-4f44-b28e-c004c08c2af4.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/1c536f8b-1c86-41e6-8001-c3dc5dfd9c0d.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/1ec0aebe-91e7-4764-b28a-3815fab3cd05.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/1f9e44dc-c76c-40fb-86ec-e7f1823f6da9.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/20442aef-1433-477f-8d9f-2aedafde4ca9.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/21e37864-7a4c-4a83-98eb-0bcc186ec5b3.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/254b3b67-5d28-415c-a47b-7bd112311090.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/260282cf-e4ce-43b9-a63f-e89089d7adc4.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/2643346f-02ba-4bcc-94db-86856d27ab5f.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/2649240e-9f1a-43ab-ac37-39bf1232f0c3.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/2d71ed39-3283-4080-8f69-71a17a39a706.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/3a0e2b04-2ce8-43d1-9e6d-fd60b4ed56bd.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/3bf35c91-993a-45ca-b1c2-3224309fc5a1.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/3c0faadf-816e-4840-b8ac-340b2c07c6a1.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/3d28ddca-4601-4b88-a44b-2f403a44598e.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/3e039481-bb60-4ee6-a59c-b3fd7c6c088c.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/420d2f1f-db3a-40c8-b51a-5dbf9f50c5c2.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/4243764a-f9df-4fc8-b2ce-1443363c9d44.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/42bc7ec6-9bd5-4fe2-9988-54f28a23d974.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/48731528-9684-4981-bf99-120ceecbb069.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/488be344-4c08-4307-ba39-24ca03143c74.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/4ea5139e-4d53-45f9-a5d1-adbde3064f55.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/4eeec4f0-f8ee-43d7-b79f-80fba6a910bb.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/52dd7b75-1b8c-4051-8b1a-62c8d6db39f6.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/538c8438-4a19-491c-af7e-155a67b1ea6a.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/538f0221-c092-43ee-9267-c3d35b31c0ed.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/571ac24d-bf6a-4271-a28f-ad0c6bcb4ec9.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/5c9db1c1-4035-4b20-b544-21a3fa31180d.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/6075ef1d-4bc8-4dcb-a1fe-855a19755a69.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/628b0fc7-5852-451b-8330-5477fd8cf940.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/62be6af2-af4f-44a3-b6af-f89a7f68cce1.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/62cf1b90-9401-4b8d-ab2a-04838b6eaa64.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/63800efe-8f6b-4171-9e98-f8bf5cec5f26.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/6481fe64-75fe-4eaf-a86f-b99bbb9cb146.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/6bbfec90-1b31-4432-bc28-6a9b0a3e0092.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/7a07d55f-4892-4939-b155-99d2b3d6d203.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/7b9c72a3-b8dd-43f6-956e-bce9f6eb4199.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/86cd97e9-d67a-4f99-9eba-70d95b851fa5.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/876997da-97b5-480a-8972-50c605df6287.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/8ee1971b-d85c-481e-95ea-773299706c51.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/931579f7-b595-4e53-8514-e30e6f4d78d8.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/93d61809-08d9-4a50-b7da-24a750d06d11.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/93e26337-da01-43d9-aa2b-05da713a6149.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/97208e75-c49c-42b6-8ba0-ef0327a4e5bf.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/9932ef30-e62e-4a7e-9fe7-32b3bbfac49e.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/a1d734b8-5d86-4cae-9170-fd90f35b4342.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/a2e9506d-4718-4b1c-b2b3-d4be8ed552e5.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/aba8900e-f857-4579-8c37-ff998d89b8d6.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/ae8fe9e6-7d63-4808-a9af-69cb5ad6f2dd.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/bc6aac83-9bb7-4f08-8853-33a05afe0d4c.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/be0a19e6-6519-42c6-ab29-779b16ae370a.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/c5a4807c-761f-4c91-8e13-0280e54470d8.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/c832794f-6845-4a8a-908c-fecb09a47149.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/ca2173da-f2c1-4e56-a994-e6512530e1e2.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/ce919ec3-767f-4bd5-bae5-30bf747a41d2.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/ceca1435-28f1-4a82-9c52-8f10608001a1.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/d62265f7-898c-460d-8d40-4e9d1e2785b2.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/d7ea1943-040e-4ec5-a658-34099f766fbd.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/e52ead9f-3c1e-4603-94cb-8c8392cfb702.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/e7e228e9-63c5-4449-a3fe-253876ba816d.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/ea2541d2-9ee3-4379-ae09-89bc6a0e4535.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/ea5d3844-44ac-4a7b-a008-2609253a06c2.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/eca316b4-f674-4db2-be16-79b0c165a86b.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/f404a692-749d-4721-96e1-3f1f96cd08af.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/fd6bd89a-db65-4f69-997b-631c52596729.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/ffa3376c-4095-498b-9667-2233f5fd9ed7.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/medalback.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/steak40.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/steak60.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/00cd185d-3484-40e6-9fda-486c8821a31c.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/03e9492b-4374-445b-b218-b8b17a6b72e8.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/0b308a47-9eff-40cc-8fe3-ca413f9cd6ed.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/0e078a43-0a57-4236-9790-c98f620e07aa.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/1855facd-1c96-411c-ae82-712e45b6fec0.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/1a78d3dd-34b7-4f44-b28e-c004c08c2af4.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/1c536f8b-1c86-41e6-8001-c3dc5dfd9c0d.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/254b3b67-5d28-415c-a47b-7bd112311090.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/2649240e-9f1a-43ab-ac37-39bf1232f0c3.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/2d71ed39-3283-4080-8f69-71a17a39a706.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/3a0e2b04-2ce8-43d1-9e6d-fd60b4ed56bd.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/3d28ddca-4601-4b88-a44b-2f403a44598e.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/420d2f1f-db3a-40c8-b51a-5dbf9f50c5c2.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/4243764a-f9df-4fc8-b2ce-1443363c9d44.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/42bc7ec6-9bd5-4fe2-9988-54f28a23d974.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/488be344-4c08-4307-ba39-24ca03143c74.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/4ea5139e-4d53-45f9-a5d1-adbde3064f55.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/4eeec4f0-f8ee-43d7-b79f-80fba6a910bb.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/52dd7b75-1b8c-4051-8b1a-62c8d6db39f6.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/5c9db1c1-4035-4b20-b544-21a3fa31180d.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/62be6af2-af4f-44a3-b6af-f89a7f68cce1.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/62cf1b90-9401-4b8d-ab2a-04838b6eaa64.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/63800efe-8f6b-4171-9e98-f8bf5cec5f26.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/6bbfec90-1b31-4432-bc28-6a9b0a3e0092.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/7b9c72a3-b8dd-43f6-956e-bce9f6eb4199.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/876997da-97b5-480a-8972-50c605df6287.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/93d61809-08d9-4a50-b7da-24a750d06d11.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/93e26337-da01-43d9-aa2b-05da713a6149.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/97208e75-c49c-42b6-8ba0-ef0327a4e5bf.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/aba8900e-f857-4579-8c37-ff998d89b8d6.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/ae8fe9e6-7d63-4808-a9af-69cb5ad6f2dd.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/bc6aac83-9bb7-4f08-8853-33a05afe0d4c.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/be0a19e6-6519-42c6-ab29-779b16ae370a.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/ca2173da-f2c1-4e56-a994-e6512530e1e2.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/e7e228e9-63c5-4449-a3fe-253876ba816d.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/eca316b4-f674-4db2-be16-79b0c165a86b.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/medals/thumbs/steak25.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/odst/popupback.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/pgcr/back-blue.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/pgcr/back-green.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/pgcr/back-red.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/pgcr/back-yellow.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/pgcr/second-inner-nav-back.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/stat_halo3banner.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/tabs/background-fade.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/tabs/tab-left.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/tabs/tab-right.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/tabs/tableheaderbkg.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/tag_approve_thumbs.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/tag_approve_thumbs_flash.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/TOD-header-back.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/01bba48a-e7ba-4370-9841-e4e87271bdea.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/07e36229-f22c-45c9-8ca4-c33269c1ae6e.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/0be8dc88-acc4-405d-9b82-1e0d8a4ca2f0.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/109d4026-a921-495c-a528-2f4471e4858a.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/1238c18d-05d2-44bf-a409-c13640c7b7dc.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/13c38c32-afda-40d1-939a-daf5403e00c5.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/15f9f22f-5915-4a62-afc6-a9022c1c74ba.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/16b65b4f-769e-4c15-bcde-7826b77b7e6c.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/1adc5848-9b55-40bf-aba7-ba8ee2e63fa2.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/21315b2e-0130-45f9-816a-76f540b6448f.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/302fcc09-2fce-4f52-b76b-0b10a9fd3fe5.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/3ab74a32-b922-4fa3-8a79-ad2e3718fff5.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/3fae4471-5f60-4b50-9ef5-662b75225945.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/4019e2e4-712a-4f70-9b22-daa89aed64be.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/430fc6c2-d0fd-407b-bf0e-8104a9d53ece.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/4720430e-605c-462c-bf37-ba5e337c664f.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/48533b67-63ac-4a0e-a752-b4ade9a4b54d.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/4b66a601-633b-4173-b575-b01dea0a7bf4.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/4c6282f6-67dd-4ac5-b27d-6ae0872c8318.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/4d09bc9f-93cf-4872-ba36-9f281aea3688.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/59bb6f01-9401-4f83-b53f-88f3acb1c90a.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/5e67db52-fcc1-4e95-8e8a-15917d2fa7e8.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/5f8fbbf9-6267-4257-9a2d-24f8c2e5441d.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/64c6b0b4-efe0-43b9-8ede-976ac7a79b8c.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/6bf4d7a5-5681-45c5-ae36-58a374681fa9.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/6c3773cf-5c9d-4ded-aee4-32b16ad84935.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/86f4b09a-5819-4563-8d8d-d775cda1cff4.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/8c0238e3-31b3-49b7-8218-db334208a9ad.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/9003754a-9ea5-4ee9-b06d-cf6677117fcd.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/915a770c-91ec-477a-8868-3fb71669f790.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/93d4ab05-1e18-4cca-b988-90643592421f.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/a4e4e26a-3f1a-444f-81ff-d37ae95ea393.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/a721fd62-2df1-422a-9dc8-2635e6a49423.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/a96efe7b-2b7a-4f9f-9c1f-c40530e10829.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/b687470e-950f-4055-a549-153b8afa467a.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/bfa81861-1bc7-49b2-b61c-a19a71844830.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/ce51fc5c-4e7e-403e-aa17-5cc8e0c95f79.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/d2d2c159-dfe9-4009-97ca-346b82f4b179.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/e2b3837c-c27f-4497-a07d-8e59f153cff6.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/e3e6ceee-8e01-4e88-8c0c-fbf8e1ad8eb9.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/e3f61b9a-3212-4dd8-b84f-26da6c8da1b2.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/e4566f4a-3b98-4e1d-9fd9-68edec7eb2ff.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/e681334b-426b-4436-a8cb-8b8647c97e57.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/e8106138-b809-40e0-84da-18ce9f35a52d.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/e9cab83b-8ca1-4c29-b7f0-92e22c706fe9.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/ea650ba1-6d9f-4916-9bb2-171e5c4061e7.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/f4267f2d-68ad-4472-8074-fac280a423ad.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/f93010a5-2ca3-4051-8c24-f1e1f56ea13e.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/f99731a6-5ae3-42ed-a6ab-e605a514b5ab.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/fb39c7c5-d4ab-4939-b30f-93489ca6bf12.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/fdb4005f-45a4-472a-8646-9763ebc75aad.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/sm_unknown.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/weapons/unknown.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/053d180d-868a-4581-b671-4c109277d548.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/0fcc9376-8901-4c14-b593-7558905c5bfc.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/2547d795-4b9d-45d7-9c74-ed4524e15bdd.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/2f18f9ea-d33c-4b2c-8580-8c562e9b128a.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/33e58541-0348-4d78-b857-ba0b9c1ce502.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/342b27cf-8147-4503-99c2-112060d171cc.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/3691d1d2-7d88-47ee-8546-77fba5609d4a.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/37fc0e43-e750-4fa2-8c24-c4adeedf5d99.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/3ec972f0-7a18-4098-9c2c-30707d104d54.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/51e63651-e446-4c28-bda5-d739466f7a05.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/548dd583-e0f2-4a7c-a506-e84671b1d4ee.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/58559a75-723b-4320-8bf8-7323f464500d.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/615440ed-c904-46d6-8caf-1c7e766db3cd.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/63797700-26cc-4bdb-80f1-f229c9f875ea.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/653d9be5-cbb5-4177-a95f-9843dc6121ea.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/6bb9ec86-b2b4-498d-885e-35cbca15129c.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/6fb070f4-7aa1-48dd-8bb2-631a9c4c3af5.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/77885f81-a686-4000-9a2c-d3409ef1ecb0.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/7ac08018-6e9a-450a-964c-5c652749f439.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/908eaf06-dbb3-4c40-a06f-4794349bc134.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/986179a8-3abb-4d60-a661-ad063670ef1b.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/9cb66d3-6336-4a3d-9427-824bd3875e33.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/a3804937-e91f-4ae4-be66-0e51845c18da.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/a3ab3bb1-00c5-493f-b0ce-6772ce0b8917.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/a61af960-b804-4b94-bbfa-26fd25431a03.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/aa8b3c7d-aa10-4099-8af4-06b2d546e59b.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/af8229e3-05fe-4e61-957b-5cb4ab292387.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/b849d033-f5d9-4f2b-bb26-acc140fcc5a5.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/c0a6599d-0110-4865-871c-720120f9f326.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/c224c576-8d90-4898-8f51-dd51cb8841e9.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/c56bde34-827b-4c3c-8842-f97e2136da25.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/ce5e2689-1905-4998-859d-541baf06bc24.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/cfedaef1-9552-433b-a077-08bf843e2c5c.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/d9f3bcd6-a8cb-4cd7-bcd6-8e642f3b1741.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/dc3ef8ca-68cb-4d5a-9311-bd67b1cba1b4.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/e5aa6002-fe30-4bc6-8e30-e995924a6ca5.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/e62e29c5-666a-4674-a5dc-b3b16a54b6a4.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/e8a5e1d7-fe1f-415f-9503-93b0d3490263.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/ec08095d-931e-4023-8c65-19b8dd63b8b0.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/f0019fd6-c502-4405-9e78-a66352c9620c.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/fa3e7e07-7f69-4046-b100-51d0e2842dfc.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/progress/grey.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/progress/texturebackground.jpg"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/00bd4168-e9b7-4f4c-b664-daa356d60e38.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/07935ca0-784b-4918-b827-b8be0710a5f2.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/0eff084b-dd5c-4464-9d25-5649b277b8e3.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/1241531f-26dd-4864-992d-d3e2ce0a24c1.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/1251f8c3-3545-417d-a03b-1f5fa1610b5a.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/15984cec-2ded-4be4-afa3-a1a1bca90329.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/1922a6a1-5317-4c1f-b2b2-18e7e2212159.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/21f2f15f-09f7-45ba-bf71-57740392cfc8.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/2f18f9ea-d33c-4b2c-8580-8c562e9b128a.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/30b8af16-a006-46a8-acf2-0140963531a8.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/33e58541-0348-4d78-b857-ba0b9c1ce502.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/3691d1d2-7d88-47ee-8546-77fba5609d4a.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/3c608dfd-0f63-4e6f-97f1-7d273539fcae.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/3dd798ad-fb86-43a5-9a85-a67d943df060.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/3dfbb8fd-402b-4217-8efc-932f4fa0f02f.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/3e145563-dcc8-4971-86ea-22034f5e85ee.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/5102bebc-048b-45e8-8605-dabe1f46a0d9.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/55289898-dbef-4215-a9c3-0c776736f00e.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/597a4e07-5a77-46a4-a76d-9b0b69fba21c.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/642e3b3e-eb35-4b26-8562-cc8be9affd31.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/736ee9cd-284f-4bfa-b29e-f67e7151baff.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/784de846-ced8-4bfa-9b44-4871234be71a.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/8636a529-98f7-4191-85e4-bf970e8433da.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/86bbad58-93b0-4969-8b92-edd7482cbd0e.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/937bee13-e428-44a6-ba44-091b8c88f607.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/9d750834-9617-430e-8f4c-b2cc563e7f16.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/aae0269f-11d7-4ea0-b106-f1226325f51d.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/b1e2c350-a8cd-4132-a248-62c0defad636.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/b9f2c885-49c3-4e10-a4f0-7c60cbfcff2f.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/bcd50b45-0ea9-43e8-b42f-cbba8a2b1823.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/bff71969-be5c-4721-99ec-1d2ebe691f13.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/c8494e1c-1f3d-4f73-9d27-c148a5e47c0f.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/d3bba555-4834-4756-a270-14e8aa0e2f33.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/d9f3bcd6-a8cb-4cd7-bcd6-8e642f3b1741.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/ddeba162-e077-4606-96fb-670221278254.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/e08aabb4-773b-4446-83ab-78f8726cdf4c.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/e3ac32ef-cdd7-42c8-821d-a5c8ba2df3bb.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/e62e29c5-666a-4674-a5dc-b3b16a54b6a4.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/e8a5e1d7-fe1f-415f-9503-93b0d3490263.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/f236545e-79aa-43e8-9b0e-2a3d58a07af6.gif"] = true
downloaded["http://halo.bungie.net/images/halo3stats/xp/small/f363e356-83ec-4223-8009-6763628ee6d0.gif"] = true
downloaded["http://halo.bungie.net/images/inside/jobs/expandbutton.gif"] = true
downloaded["http://halo.bungie.net/images/reachStatsNew/bg_linkArrow.png"] = true
downloaded["http://halo.bungie.net/images/reachStatsNew/bg_linkArrow_on.png"] = true
downloaded["http://halo.bungie.net/images/reachStatsNew/bg_linkArrowReverse.png"] = true
downloaded["http://halo.bungie.net/images/reachStatsNew/bg_linkArrowReverse_on.png"] = true
downloaded["http://halo.bungie.net/images/redeem/btn_createaccount.jpg"] = true
downloaded["http://halo.bungie.net/images/redeem/btn_signin.jpg"] = true
downloaded["http://halo.bungie.net/images/redeem/btn_submit.jpg"] = true
downloaded["http://halo.bungie.net/images/spacer.gif"] = true
downloaded["http://halo.bungie.net/javascript/cookie.js?ver=2.0.4777.31696"] = true
downloaded["http://halo.bungie.net/javascript/error_handling.js"] = true
downloaded["http://halo.bungie.net/javascript/firefox_submit_fix.js"] = true
downloaded["http://halo.bungie.net/javascript/forums.js"] = true
downloaded["http://halo.bungie.net/javascript/jquery.sparkline.js"] = true
downloaded["http://halo.bungie.net/javascript/rad3.js?ver=2.0.4777.31696"] = true
downloaded["http://halo.bungie.net/javascript/silverlight2.js"] = true
downloaded["http://halo.bungie.net/javascript/utility.js?ver=2.0.4777.31696"] = true
downloaded["http://halo.bungie.net/ScriptResource.axd?d=2acTX_Agj-yfZ0JzGeca1fGVW31nB0MNeZG_TpSH2Ic3amaqk3GrPYjSeEjil6xWH7vklC8a1cAQ68afBJopssCNv5tQf0tZiZli2RU1lid_cuzIc7aZYa9hnhViCPNKa4Y6_A2&t=59936b01"] = true
downloaded["http://halo.bungie.net/ScriptResource.axd?d=7ic1Pi3kTF5hi86WYE9VjvFwvthRRXUCufQYt2spI5Exm_oNpThkTFvgHzKX_aAv8aTIX5srEo-oqyOrOx4c7FAUuncEpN9qUARpvMOmOOqe8nsX0&t=59936b01"] = true
downloaded["http://halo.bungie.net/ScriptResource.axd?d=_BZsPQ5PfOVsF3DEya8JSl4EkjxEwcLZ84BntU3pf09EPAlDzrbyZtvG4uYPXr420lPqbCO8r_-ORX7e7D7NJIUIlYOG6e-qJXIXydQ5Uxld6uE3xFRC6-MnReVTNNLtc7jVLQ2&t=59936b01"] = true
downloaded["http://halo.bungie.net/ScriptResource.axd?d=AnB4_9H4sXtIYoZQwJFAKVsYVHnSyThBUaa6AYDjY0RZyiXZHL7a717Kc6W9facP0hx6hdUnvwFi-mpJvF9md-Cmwmn6k-ymblprfLMzPogoeuxtwCgqN2hsXAA1&t=59936b01"] = true
downloaded["http://halo.bungie.net/ScriptResource.axd?d=B5Ob0v6fop9IlZ5FQkKY2WwMj8jpPAfwL5zG-fNelDsX-hAVu7avWfq_Oq5Kusj04PhuKJ6oQKl8P5lFPFJaxImE6u8y1mSFgm-CBw2&t=59936b01"] = true
downloaded["http://halo.bungie.net/ScriptResource.axd?d=CyQomTdIAtjJD82SM0ZPWHqIdUTSVxb5TiPvOb_ayxJfsLAdNZqp3GDjKcayGuPiQv9ULS9MeceG3xpxrqx-M7QqzG-QIIK9Gmwubw2&t=59936b01"] = true
downloaded["http://halo.bungie.net/ScriptResource.axd?d=dfkRAfe1DSI0EDvPn4MHgb02kPlArLMWNpRdm73ZTzs4pJFDDveAzzmDafrycx7etkj5b9ImOMvAH3mDniLCHAL-BInhqOIy4cnLIIu3MbysUnXXHcTm-Wzbp7I1&t=59936b01"] = true
downloaded["http://halo.bungie.net/ScriptResource.axd?d=kKJLkiI50O0KaH-u5iwggVh4e-rl1x4IJ7eH4tohlaIx_oH7pkaFt620lhn4J9wdEgEK4UR3AMnFUrPvVuJWN5VyOJjFHF_hwCzW4D_cZ6dRPqhjKa2iezbcpLDGRy3MopkUag2&t=59936b01"] = true
downloaded["http://halo.bungie.net/ScriptResource.axd?d=KkTRc_pHszrC-LMZ1NTf3wdYLqOlrj3ptECm6lDgWxRJmItK9DhaxxRLmevDyGlwIb4DpoR7J4_T01OilXx1tkjle_am6edYQgzFnMsYvA4MpbavGWwmO9-a6xM1&t=59936b01"] = true
downloaded["http://halo.bungie.net/ScriptResource.axd?d=QlM-ccEmER3k3rnYyKi52BtGEdNuoXXs6vO-i5sq1U-vU7Vi6vcQI1jmx_rMoYUeIrpKSpEsgg3_v2DgxJF9ZhAROpa39kZF6pg7EgU5SkBhwcXxDi4rCcHSCy41&t=59936b01"] = true
downloaded["http://halo.bungie.net/ScriptResource.axd?d=qRGQrvQSiYq8w1w00ZgyyotQS0AfKshI1wRFmX2UbJCE5E2im6MBVUTT19omEfCNlp-zvVXmZKl91FsiHcHoJWVic7OJMtqhKyUwOwtCfFtbhLd8k53R71Vbdfs1&t=59936b01"] = true
downloaded["http://halo.bungie.net/ScriptResource.axd?d=z-a9kl92H0nQq5bbdkpbhlNzPBOdPPfD_KafsE9la5sgLfBgQrWDb02f-l-x5HUWh_dRK5qNsdLJVlXpkCAyEr0BDL6rZS2zzFIEWZjdoo9r0mSzEOIDLrktzpqoru5Qc1n4jA2&t=348b0da"] = true
downloaded["http://halo.bungie.net/ScriptResource.axd?d=zCheWMu7215ZObQx8Dp-nJiI2Sk4LmWUq_8FoNaYI2l1P7WSe40dvkUf5xWZRRo7nj11LI-fHw4Xg0fdFVA1q4RnMPo3MixYFjJiomg6nyP3NdXY0&t=59936b01"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=0&2=0&3=0&fi=0&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=0&2=0&3=0&fi=0&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=0&2=1&3=0&fi=3&bi=2&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=0&2=1&3=0&fi=3&bi=2&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=0&2=12&3=9&fi=52&bi=1&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=0&2=12&3=9&fi=52&bi=1&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=0&2=2&3=0&fi=10&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=0&2=2&3=0&fi=10&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=0&2=21&3=0&fi=16&bi=30&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=0&2=21&3=0&fi=16&bi=30&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=0&2=9&3=3&fi=28&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=0&2=9&3=3&fi=28&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=10&2=0&3=0&fi=45&bi=23&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=10&2=0&3=0&fi=45&bi=23&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=10&2=3&3=3&fi=61&bi=37&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=10&2=3&3=3&fi=61&bi=37&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=12&2=18&3=10&fi=12&bi=39&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=12&2=18&3=10&fi=12&bi=39&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=13&2=2&3=13&fi=79&bi=24&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=13&2=2&3=13&fi=79&bi=24&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=16&2=2&3=3&fi=65&bi=11&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=16&2=2&3=3&fi=65&bi=11&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=17&2=0&3=0&fi=17&bi=1&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=17&2=0&3=0&fi=17&bi=1&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=17&2=26&3=26&fi=52&bi=25&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=17&2=26&3=26&fi=52&bi=25&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=18&2=3&3=1&fi=4&bi=15&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=18&2=3&3=1&fi=4&bi=15&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=19&2=2&3=12&fi=24&bi=38&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=19&2=2&3=12&fi=24&bi=38&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=2&2=0&3=10&fi=38&bi=2&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=2&2=0&3=10&fi=38&bi=2&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=2&2=0&3=24&fi=2&bi=37&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=2&2=0&3=24&fi=2&bi=37&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=2&2=0&3=25&fi=32&bi=16&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=2&2=0&3=25&fi=32&bi=16&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=2&2=0&3=3&fi=27&bi=2&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=2&2=0&3=3&fi=27&bi=2&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=2&2=1&3=0&fi=39&bi=37&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=2&2=1&3=0&fi=39&bi=37&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=2&2=10&3=0&fi=32&bi=16&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=2&2=10&3=0&fi=32&bi=16&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=2&2=10&3=27&fi=65&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=2&2=10&3=27&fi=65&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=2&2=10&3=27&fi=8&bi=36&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=2&2=10&3=27&fi=8&bi=36&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=2&2=15&3=15&fi=4&bi=1&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=2&2=15&3=15&fi=4&bi=1&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=2&2=2&3=0&fi=50&bi=13&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=2&2=2&3=0&fi=50&bi=13&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=2&2=2&3=2&fi=12&bi=40&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=2&2=2&3=2&fi=12&bi=40&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=2&2=2&3=3&fi=2&bi=1&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=2&2=2&3=3&fi=2&bi=1&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=2&2=21&3=3&fi=27&bi=42&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=2&2=21&3=3&fi=27&bi=42&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=2&2=3&3=18&fi=2&bi=3&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=2&2=3&3=18&fi=2&bi=3&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=2&2=9&3=3&fi=0&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=2&2=9&3=3&fi=0&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=21&2=25&3=0&fi=50&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=21&2=25&3=0&fi=50&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=21&2=27&3=12&fi=4&bi=44&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=21&2=27&3=12&fi=4&bi=44&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=24&2=0&3=2&fi=63&bi=44&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=24&2=0&3=2&fi=63&bi=44&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=24&2=21&3=2&fi=65&bi=42&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=24&2=21&3=2&fi=65&bi=42&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=26&2=26&3=0&fi=7&bi=26&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=26&2=26&3=0&fi=7&bi=26&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=26&2=3&3=0&fi=19&bi=25&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=26&2=3&3=0&fi=19&bi=25&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=27&2=9&3=0&fi=50&bi=13&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=27&2=9&3=0&fi=50&bi=13&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=3&2=0&3=3&fi=10&bi=38&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=3&2=0&3=3&fi=10&bi=38&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=3&2=1&3=16&fi=39&bi=34&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=3&2=1&3=16&fi=39&bi=34&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=3&2=1&3=2&fi=10&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=3&2=1&3=2&fi=10&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=3&2=10&3=2&fi=17&bi=43&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=3&2=10&3=2&fi=17&bi=43&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=3&2=18&3=3&fi=56&bi=47&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=3&2=18&3=3&fi=56&bi=47&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=9&2=0&3=0&fi=45&bi=23&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=9&2=0&3=0&fi=45&bi=23&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=9&2=0&3=9&fi=10&bi=45&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=9&2=0&3=9&fi=10&bi=45&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=9&2=2&3=2&fi=54&bi=39&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=9&2=2&3=2&fi=54&bi=39&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=9&2=3&3=0&fi=45&bi=1&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=9&2=3&3=0&fi=45&bi=1&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=0&1=9&2=9&3=9&fi=23&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=0&1=9&2=9&3=9&fi=23&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=1&1=13&2=16&3=17&fi=36&bi=37&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=1&1=13&2=16&3=17&fi=36&bi=37&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=1&1=2&2=10&3=27&fi=0&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=1&1=2&2=10&3=27&fi=0&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=1&1=21&2=9&3=21&fi=56&bi=1&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=1&1=21&2=9&3=21&fi=56&bi=1&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=1&1=24&2=3&3=7&fi=38&bi=43&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=1&1=24&2=3&3=7&fi=38&bi=43&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=10&1=19&2=9&3=3&fi=64&bi=44&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=10&1=19&2=9&3=3&fi=64&bi=44&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=12&1=0&2=12&3=11&fi=69&bi=29&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=12&1=0&2=12&3=11&fi=69&bi=29&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=12&1=0&2=12&3=14&fi=37&bi=19&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=12&1=0&2=12&3=14&fi=37&bi=19&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=12&1=10&2=10&3=10&fi=20&bi=13&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=12&1=10&2=10&3=10&fi=20&bi=13&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=12&1=10&2=10&3=10&fi=18&bi=40&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=12&1=10&2=10&3=10&fi=18&bi=40&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=12&1=12&2=12&3=12&fi=0&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=12&1=12&2=12&3=12&fi=0&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=12&1=12&2=12&3=2&fi=56&bi=19&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=12&1=12&2=12&3=2&fi=56&bi=19&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=12&1=12&2=6&3=14&fi=57&bi=19&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=12&1=12&2=6&3=14&fi=57&bi=19&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=12&1=19&2=17&3=18&fi=64&bi=11&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=12&1=19&2=17&3=18&fi=64&bi=11&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=12&1=19&2=9&3=3&fi=64&bi=44&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=12&1=19&2=9&3=3&fi=64&bi=44&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=12&1=2&2=10&3=27&fi=12&bi=15&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=12&1=2&2=10&3=27&fi=12&bi=15&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=12&1=2&2=2&3=2&fi=14&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=12&1=2&2=2&3=2&fi=14&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=12&1=2&2=2&3=6&fi=26&bi=27&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=12&1=2&2=2&3=6&fi=26&bi=27&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=12&1=2&2=21&3=2&fi=46&bi=12&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=12&1=2&2=21&3=2&fi=46&bi=12&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=12&1=2&2=3&3=0&fi=12&bi=2&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=12&1=2&2=3&3=0&fi=12&bi=2&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=12&1=2&2=6&3=24&fi=64&bi=36&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=12&1=2&2=6&3=24&fi=64&bi=36&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=12&1=24&2=27&3=12&fi=10&bi=38&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=12&1=24&2=27&3=12&fi=10&bi=38&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=12&1=4&2=2&3=2&fi=31&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=12&1=4&2=2&3=2&fi=31&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=0&2=9&3=0&fi=11&bi=41&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=0&2=9&3=0&fi=11&bi=41&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=6&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=6&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=62&bi=13&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=62&bi=13&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=30&bi=14&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=30&bi=14&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=62&bi=15&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=62&bi=15&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=35&bi=16&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=35&bi=16&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=67&bi=16&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=67&bi=16&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=53&bi=17&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=53&bi=17&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=4&bi=2&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=4&bi=2&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=16&bi=23&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=16&bi=23&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=52&bi=23&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=52&bi=23&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=20&bi=28&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=20&bi=28&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=51&bi=29&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=51&bi=29&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=58&bi=3&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=58&bi=3&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=37&bi=33&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=37&bi=33&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=48&bi=33&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=48&bi=33&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=14&bi=34&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=14&bi=34&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=33&bi=38&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=33&bi=38&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=58&bi=38&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=58&bi=38&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=74&bi=39&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=74&bi=39&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=41&bi=4&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=41&bi=4&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=41&bi=40&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=41&bi=40&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=54&bi=40&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=54&bi=40&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=55&bi=40&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=55&bi=40&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=47&bi=42&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=47&bi=42&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=1&bi=45&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=1&bi=45&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=35&bi=45&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=35&bi=45&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=79&bi=46&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=79&bi=46&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=18&bi=5&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=18&bi=5&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=63&bi=8&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=63&bi=8&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=27&fi=20&bi=9&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=27&fi=20&bi=9&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=10&3=3&fi=53&bi=8&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=10&3=3&fi=53&bi=8&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=2&2=12&3=10&fi=14&bi=16&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=2&2=12&3=10&fi=14&bi=16&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=13&1=21&2=25&3=25&fi=11&bi=12&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=13&1=21&2=25&3=25&fi=11&bi=12&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=15&1=2&2=10&3=27&fi=53&bi=36&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=15&1=2&2=10&3=27&fi=53&bi=36&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=15&1=2&2=25&3=2&fi=6&bi=40&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=15&1=2&2=25&3=2&fi=6&bi=40&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=15&1=8&2=8&3=21&fi=16&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=15&1=8&2=8&3=21&fi=16&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=16&1=16&2=2&3=2&fi=17&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=16&1=16&2=2&3=2&fi=17&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=16&1=17&2=2&3=5&fi=11&bi=14&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=16&1=17&2=2&3=5&fi=11&bi=14&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=17&1=18&2=17&3=18&fi=27&bi=17&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=17&1=18&2=17&3=18&fi=27&bi=17&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=17&1=2&2=17&3=3&fi=68&bi=1&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=17&1=2&2=17&3=3&fi=68&bi=1&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=18&1=0&2=10&3=3&fi=4&bi=15&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=18&1=0&2=10&3=3&fi=4&bi=15&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=18&1=0&2=2&3=18&fi=37&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=18&1=0&2=2&3=18&fi=37&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=18&1=0&2=2&3=2&fi=64&bi=35&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=18&1=0&2=2&3=2&fi=64&bi=35&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=18&1=0&2=9&3=1&fi=27&bi=44&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=18&1=0&2=9&3=1&fi=27&bi=44&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=18&1=10&2=1&3=19&fi=11&bi=36&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=18&1=10&2=1&3=19&fi=11&bi=36&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=18&1=19&2=2&3=23&fi=2&bi=37&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=18&1=19&2=2&3=23&fi=2&bi=37&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=18&1=2&2=0&3=2&fi=16&bi=40&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=18&1=2&2=0&3=2&fi=16&bi=40&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=18&1=2&2=10&3=27&fi=47&bi=37&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=18&1=2&2=10&3=27&fi=47&bi=37&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=18&1=2&2=18&3=18&fi=30&bi=15&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=18&1=2&2=18&3=18&fi=30&bi=15&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=18&1=2&2=18&3=18&fi=20&bi=4&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=18&1=2&2=18&3=18&fi=20&bi=4&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=18&1=2&2=18&3=18&fi=54&bi=4&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=18&1=2&2=18&3=18&fi=54&bi=4&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=18&1=2&2=18&3=18&fi=4&bi=9&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=18&1=2&2=18&3=18&fi=4&bi=9&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=18&1=2&2=18&3=6&fi=21&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=18&1=2&2=18&3=6&fi=21&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=18&1=24&2=0&3=9&fi=4&bi=38&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=18&1=24&2=0&3=9&fi=4&bi=38&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=18&1=3&2=3&3=1&fi=38&bi=36&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=18&1=3&2=3&3=1&fi=38&bi=36&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=18&1=3&2=3&3=3&fi=0&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=18&1=3&2=3&3=3&fi=0&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=19&1=1&2=17&3=2&fi=19&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=19&1=1&2=17&3=2&fi=19&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=19&1=28&2=0&3=0&fi=45&bi=13&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=19&1=28&2=0&3=0&fi=45&bi=13&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=2&1=0&2=0&3=3&fi=38&bi=25&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=2&1=0&2=0&3=3&fi=38&bi=25&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=2&1=0&2=10&3=10&fi=20&bi=4&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=2&1=0&2=10&3=10&fi=20&bi=4&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=46&0=2&1=0&2=2&3=3&fi=74&bi=15&fl=1&m=2"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=2&1=0&2=3&3=3&fi=4&bi=47&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=2&1=0&2=3&3=3&fi=4&bi=47&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=2&1=12&2=2&3=12&fi=72&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=2&1=12&2=2&3=12&fi=72&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=2&1=18&2=10&3=2&fi=39&bi=43&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=2&1=18&2=10&3=2&fi=39&bi=43&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=2&1=2&2=0&3=3&fi=54&bi=38&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=2&1=2&2=0&3=3&fi=54&bi=38&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=2&1=2&2=1&3=0&fi=2&bi=1&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=2&1=2&2=1&3=0&fi=2&bi=1&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=2&1=2&2=1&3=0&fi=10&bi=43&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=2&1=2&2=1&3=0&fi=10&bi=43&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=2&1=2&2=10&3=27&fi=36&bi=36&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=2&1=2&2=10&3=27&fi=36&bi=36&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=2&1=2&2=10&3=3&fi=10&bi=33&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=2&1=2&2=10&3=3&fi=10&bi=33&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=2&1=2&2=2&3=16&fi=30&bi=43&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=2&1=2&2=2&3=16&fi=30&bi=43&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=2&1=2&2=2&3=2&fi=66&bi=40&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=2&1=2&2=2&3=2&fi=66&bi=40&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=2&1=2&2=2&3=3&fi=40&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=2&1=2&2=2&3=3&fi=40&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=2&1=2&2=2&3=3&fi=11&bi=12&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=2&1=2&2=2&3=3&fi=11&bi=12&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=2&1=2&2=24&3=28&fi=13&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=2&1=2&2=24&3=28&fi=13&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=2&1=2&2=25&3=25&fi=63&bi=13&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=2&1=2&2=25&3=25&fi=63&bi=13&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=2&1=2&2=3&3=2&fi=17&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=2&1=2&2=3&3=2&fi=17&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=2&1=27&2=27&3=28&fi=27&bi=27&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=2&1=27&2=27&3=28&fi=27&bi=27&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=2&1=3&2=2&3=3&fi=37&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=2&1=3&2=2&3=3&fi=37&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=2&1=3&2=2&3=9&fi=47&bi=3&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=2&1=3&2=2&3=9&fi=47&bi=3&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=2&1=6&2=3&3=11&fi=26&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=2&1=6&2=3&3=11&fi=26&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=2&1=9&2=18&3=3&fi=7&bi=10&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=2&1=9&2=18&3=3&fi=7&bi=10&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=20&1=12&2=25&3=11&fi=12&bi=8&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=20&1=12&2=25&3=11&fi=12&bi=8&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=21&1=0&2=0&3=0&fi=0&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=21&1=0&2=0&3=0&fi=0&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=21&1=1&2=1&3=1&fi=27&bi=10&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=21&1=1&2=1&3=1&fi=27&bi=10&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=21&1=2&2=12&3=21&fi=16&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=21&1=2&2=12&3=21&fi=16&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=21&1=2&2=18&3=18&fi=12&bi=44&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=21&1=2&2=18&3=18&fi=12&bi=44&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=21&1=2&2=21&3=21&fi=48&bi=26&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=21&1=2&2=21&3=21&fi=48&bi=26&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=21&1=2&2=21&3=21&fi=12&bi=43&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=21&1=2&2=21&3=21&fi=12&bi=43&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=21&1=2&2=22&3=21&fi=64&bi=40&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=21&1=2&2=22&3=21&fi=64&bi=40&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=21&1=21&2=3&3=25&fi=21&bi=36&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=21&1=21&2=3&3=25&fi=21&bi=36&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=21&1=25&2=22&3=21&fi=68&bi=44&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=21&1=25&2=22&3=21&fi=68&bi=44&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=21&1=6&2=0&3=6&fi=68&bi=42&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=21&1=6&2=0&3=6&fi=68&bi=42&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=24&1=23&2=0&3=21&fi=63&bi=13&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=24&1=23&2=0&3=21&fi=63&bi=13&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=24&1=29&2=26&3=29&fi=44&bi=26&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=24&1=29&2=26&3=29&fi=44&bi=26&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=25&1=20&2=11&3=25&fi=60&bi=15&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=25&1=20&2=11&3=25&fi=60&bi=15&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=26&1=2&2=2&3=2&fi=27&bi=25&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=26&1=2&2=2&3=2&fi=27&bi=25&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=26&1=26&2=11&3=2&fi=60&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=26&1=26&2=11&3=2&fi=60&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=27&1=2&2=2&3=2&fi=17&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=27&1=2&2=2&3=2&fi=17&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=3&1=0&2=0&3=3&fi=38&bi=43&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=3&1=0&2=0&3=3&fi=38&bi=43&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=3&1=0&2=2&3=3&fi=79&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=3&1=0&2=2&3=3&fi=79&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=3&1=0&2=21&3=21&fi=65&bi=41&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=3&1=0&2=21&3=21&fi=65&bi=41&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=3&1=0&2=3&3=3&fi=14&bi=7&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=3&1=0&2=3&3=3&fi=14&bi=7&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=3&1=0&2=9&3=9&fi=23&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=3&1=0&2=9&3=9&fi=23&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=3&1=1&2=16&3=0&fi=27&bi=47&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=3&1=1&2=16&3=0&fi=27&bi=47&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=3&1=2&2=18&3=0&fi=59&bi=42&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=3&1=2&2=18&3=0&fi=59&bi=42&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=3&1=2&2=2&3=2&fi=17&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=3&1=2&2=2&3=2&fi=17&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=3&1=2&2=2&3=2&fi=19&bi=40&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=3&1=2&2=2&3=2&fi=19&bi=40&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=3&1=2&2=2&3=3&fi=79&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=3&1=2&2=2&3=3&fi=79&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=3&1=2&2=2&3=3&fi=43&bi=9&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=3&1=2&2=2&3=3&fi=43&bi=9&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=3&1=2&2=3&3=0&fi=49&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=3&1=2&2=3&3=0&fi=49&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=3&1=2&2=3&3=2&fi=17&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=3&1=2&2=3&3=2&fi=17&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=3&1=2&2=3&3=3&fi=43&bi=11&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=3&1=2&2=3&3=3&fi=43&bi=11&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=3&1=2&2=3&3=3&fi=53&bi=40&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=3&1=2&2=3&3=3&fi=53&bi=40&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=3&1=24&2=24&3=24&fi=38&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=3&1=24&2=24&3=24&fi=38&bi=0&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=3&1=29&2=0&3=29&fi=44&bi=26&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=3&1=29&2=0&3=29&fi=44&bi=26&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=3&1=3&2=1&3=0&fi=11&bi=4&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=3&1=3&2=1&3=0&fi=11&bi=4&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=3&1=3&2=2&3=2&fi=29&bi=1&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=3&1=3&2=2&3=2&fi=29&bi=1&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=3&1=7&2=0&3=3&fi=6&bi=5&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=3&1=7&2=0&3=3&fi=6&bi=5&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=30&1=0&2=2&3=0&fi=17&bi=1&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=30&1=0&2=2&3=0&fi=17&bi=1&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=6&1=0&2=2&3=0&fi=20&bi=25&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=6&1=0&2=2&3=0&fi=20&bi=25&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=6&1=12&2=6&3=2&fi=12&bi=13&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=6&1=12&2=6&3=2&fi=12&bi=13&fl=0&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=6&1=2&2=0&3=6&fi=52&bi=37&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=6&1=2&2=0&3=6&fi=52&bi=37&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=6&1=2&2=12&3=3&fi=2&bi=41&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=6&1=2&2=12&3=3&fi=2&bi=41&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=6&1=2&2=18&3=3&fi=61&bi=1&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=6&1=2&2=18&3=3&fi=61&bi=1&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=6&1=27&2=3&3=6&fi=65&bi=15&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=6&1=27&2=3&3=6&fi=65&bi=15&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=6&1=3&2=25&3=7&fi=27&bi=9&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=6&1=3&2=25&3=7&fi=27&bi=9&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=9&1=0&2=0&3=9&fi=72&bi=16&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=9&1=0&2=0&3=9&fi=72&bi=16&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=25&0=9&1=3&2=3&3=9&fi=10&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/emblem.ashx?s=90&0=9&1=3&2=3&3=9&fi=10&bi=0&fl=1&m=1"] = true
downloaded["http://halo.bungie.net/Stats/StatControls/"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=0mljMvV-jNr50znAQRfmnf_HYX79BaRjgau-PfNHuPLDVc64BShl5QtGAiEgfUPs8qDW1F0leX_c_wDPNz39fSwR_xAv5yr-Spy_eM4YOeiwrvUgQ1ZlyqdNwGr5FhMul95XIg2&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=101cV8XE7LBObKPEkJjwT5kiIrRBIevzLV2zkb_3vcvtQ1uoL8eappuVVrr4JQR_iBytkstMJEemqyLvoSapNWfNqBPhChpuRX5CT3ilTH8tF7FrdAdb_D75oIV_aO8XBOd69GGK5qIoQOKZ0&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=16TLQ7LlHtrSxcp8HhU15aScLrAQRgtfqyG_ydqMrAlAP4ZSkVf2M4H51zfSBdKJKTyoIbLNQlZeKv4kVE7PghDmaoyghRQpBeggnQ2&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=1thSdpR-eDG-VnjR82qSA5uOXrMafBj7HYEfMG1hxEZWHLTtbG0fUhTzhYDpY_8KVFGVj9huoPA2_ZOfzJFyhtybZZq6YZC3LiFwFahz8LE-wGetVz0xRHfLHl-eSl6jgUtNjHfh223dqAaw0&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=38pN0ZyntZmzgbB_YVSvNmFZqu8wzT0Bx8ctu6dByT_MO6UJ_E5VVmOa5R72qjhf6cHuwQvT7jE6EcOHboIhGLwCWEot7ml2damAF323HoUOGn1w_dDuWlo_dUc1&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=6C7gUaxL8U9LeSfovm4r7e9gg8nb9zdZt_196V09wcBQlCDGtdq81rk1YuHaMiBTUERJQmqy9geT9AK-vDfMZdjbZoBQlLrLS3gPUMSKviVLJrqBVHjyQZKpmaBo9D5pAuA0Pbx-_tUj8bE60&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=7PKakhYo26LWQbyltyreX5Gxp5BQaV3RMz1-UoMzibGFR7YpWHzuSM25GvAU5hNv46XRfbHIMdJOqCuQDLjQmfkG83v7yA9KE5alpg2&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=8cfJ-_4-LDAWgn4UKL73bXzBVUXWdbUgWTmVh7jeaEdUMG4c7hXzAz0XC3YksGuLzlIKF96Ugiugek3fr4yxVhCoSeD8RIJqxldYTMDARH_TRp-jfKkHEpOmIT4rcCz7KMfN1_paU_1MNf8s0&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=DjqGBJMxs-g7JVkUfmafOTc10QoR7dl6Wd8-1L6EhR8IbA0W6qcGUBY_cYv6iRV5MmUbS9XJP2VKmIRtj0D8xajdCdqYip6zMztefyHfw_f2Jnho11ll-Gd8euclns91P3eGHVbktkvaNb_l0&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=gdeIi5ZCc9T-wrIyYb6h6Ktv7oKl2FHoFqlNYTkvISTt6CU9wJGZCflFRqCnCTq_MInVuMyZA_CfptXIhL0P7hESust3TEN-mCC-lhKiIJvxV1HDkx-zwsbdXZKrYOG0tQhngsndHWuqJX-90&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=imI2FWH9aY2dN3xJYLtC4bMLImQEnZQlz8Pex5oE1FyMek5cI-VR17H0VxwoSkuDwADTJiG8i8j7Rege2MQppZ-2tXbEhoEmkGW3g3OoVv4I-2UgPrMV4SDVUdg1&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=khyrmaeA1WGpmjyztQ3xCdSFAtk6AmqgMTrbKYPzg1cvkJ0dG5QHZB73nEe_KJYqlSHbny4B3VBoHqfi0SRa6bfZ1ZGz3hzjzOu2J8uficrZ05N60&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=loozOmc_sHRfzevyTWTo8DHOJHB-jJKsZ7fRIiNvq--BVfx3JKasGvBHPmGjF5G1Y079a2oHFCfoJ-23os4Scn5Z0ik8TJS27D3MK75pkWXWXnuavlFHWZDb7CJI_rDqizXKSg2&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=mBW69E8LE_2e3X98obm55Uz__YJFceEnp9mRwCzAOPM3dvuYZrQNVZt0q6lQCGfWtojLp0MNoOydtNFziVBQbnilzhUHfexOrm2X7flV1N9Qx-HwLzQX8Hkjv8bOrGgLDoS7kqFsYw63YvhQ0&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=mbwA4IhUWajTgOcbom3Ys7BnrcGWEL-J1cdfPXiop8OD6M2Z6d1FJGLT-4MvWpOxtG45dR5B5mkseQ2eg8m2_lAxe073oG1ZyYFXbLXKZM8pgRiFkd9xPePK3UnRBbVOgZ9nYA2&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=nmKRsV0MsoPoa-9aoSu275qyc7FfDaENax5Lqmv7LDmxNwF-wJhAUWj7rt59EDKitcfCs-n-kb-zk5bJckVNz44J9VAtaC50iUvQnP5rqlcLPSdiOdnG4tgXzPA1&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=o0wmLPDDag4TAIhxdp9pnQhItjCOYiXhhcoByNJe5pcJLj28swc30Q3E02Gld5DQJw11juGi0ieqMquQ0SbP32Pl4a3ZBY8JUyLPyDNm5FuLp0OkyWqlxVCXWp-tjtvPYIcq-A2&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=OQr0TOQO3IjrkXl-mOaYJey3kEQYtx6Ldv3HkGjSsMcZR4MZ6Wb2q09X2cO-hDPVMlSX0e65eGAm6L7eyb-OewM8AGKJBqaJMan-6LghagwtdtWwk5GRt2LHXRsNaX7AIRQe7A2&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=os3Bg4hCiyL9Z-SujRXfKiPWDYF9RZMTF0PbY0La2mNPjb8mTJuvsLnKdM9R3ANNE-7n9vp3wVGA7WhHo2LMb2D6MuPTPOgjv_C11eiuz3ljozcTHwMAbCovl2M90o7oleQskn6zAtJC4_t50&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=pcwSK_uz0NnVXwgik-uGaP9I0dHE4sSh22NyitaH26hGbcScb1jCe1qL1Qx9GBj6MiV7BAmi3_EJx4rFAs23N7jRo3Xvqj539s6T2dTNobqumpMLAFWGJU93OY9W-QPu6cqCkHWLI3iNmnYl0&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=RbnFFG92EY2P5VV7Tzhx0EBT9YDssgRa1qsmP9wI6SE-yD4Hhz1tt183UTTU-oE1SDVW-n5GCRI795-RHn7Ij3_--JRTJXyJ4wDtz6aT6CFMRV0EciKxjJrUWSvIRggwHhfdtQ2&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=riaAmXm_pBQq8OK8-RDBx0Zi7K4jlM0HYxF7H7KL0YfblseYgb9OGWe60LXZtDG55Z-t4aRhW-UerGcf7YeXku1Sy8YA2xZDeKPo7fWI2Ke5-2aJC1sQoyn7rRi8cRFK02yaDJbj3JEJg5wl0&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=T_JH0oBu2h792F91hkd_P2yF7wo9kFQO1PBWuYhalvBf4NrqRgn2oWft7_A8dsqrcJFj4bhsmIscNxK-tUDAMirNfHd9eqpvmBOTuwUCbKjQ6UBEz7InxDBmG241&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=tAhd2BFWFi78FMoSfWF1mCJgC0tICwoWIidWWrWDtgVPsObxHkuRWr2W1_1o4w2XXtIWySus_KPBnLIqGJVU5KVp2-V4FWjLRsChK5rK48Jyd6UQTy9FfpxgO9_0DP5Mx6oGFXJDE3WBBUrQ0&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=TQRwcYYv2Xsc3x8EM68BTMb_MB4vk5kgzNbYd6N7U3x3L2ZCnajmTnxTYW7pxDzeVszlWIbsWlqY-GP2oiWNngQvnY7yZEe65vZlQ-06xfUQCgSmUpxw3R5gK8vcK-b6qh6ySg2&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=wEWwPZHuu26iljF70B-tomZAG247MKogdtTjLDgcTnbnR56zYZGOCTBcAp7TLhske3p5mbSkChUg68IhoysA4QAHkfC88VbYD4yV6y4S_5sGH8Bx5wstWrGoJB08dAvR-En8XYvVR-GRQN6M0&t=634756423240000000"] = true
downloaded["http://halo.bungie.net/WebResource.axd?d=zJ2ICLj6HfU_r8x0psUFW_DEiRgrSlZqQyNgZ8k15DIlOlt_Spxzx9FWmByFlI_I--jvt7fkFzpr5qS2Likps6oO3I5KBqqw11pU6uW63WOA1YWYF2pV4jH4m7NoSFAPQFsCDHvW-JcCl9SG0&t=634756423240000000"] = true

load_json_file = function(file)
  if file then
    local f = io.open(file)
    local data = f:read("*all")
    f:close()
    return JSON:decode(data)
  else
    return nil
  end
end

read_file = function(file)
  if file then
    local f = assert(io.open(file))
    local data = f:read("*all")
    f:close()
    return data
  else
    return ""
  end
end

wget.callbacks.download_child_p = function(urlpos, parent, depth, start_url_parsed, iri, verdict, reason)
  local url = urlpos["url"]["url"]
  local html = urlpos["link_expect_html"]
  local parenturl = parent["url"]
  local html = nil
  
  if downloaded[url] == true or addedtolist[url] == true then
    return false
  end
  
  if item_type == "halo3file" then
    if string.match(url, "[^0-9]"..item_value.."[0-9][0-9]")
      or string.match(url, "/javascript/")
      or string.match(url, "/base_css/")
      or string.match(url, "/images/")
      or string.match(url, "/Silverlight/")
      or string.match(url, "/App_Themes/")
      or string.match(url, "/WebResource%.axd")
      or string.match(url, "/emblem%.ashx")
      or string.match(url, "/GameFiles%.aspx")
      or string.match(url, "/gamestatscampaignhalo3%.aspx")
      or string.match(url, "/odstg%.aspx")
      or string.match(url, "/bprovideo/")
      or string.match(url, "/ScriptResource%.axd")
      or string.match(url, "/Screenshot%.ashx")
      or string.match(url, "silverlight%.dlservice%.microsoft%.com")
      or string.match(url, "/GameStatsHalo3%.aspx") then
      if not string.match(url, "[0-9]?"..item_value.."[0-9][0-9][0-9]")
        and not string.match(url, "PlayerStatsHalo3%.aspx%?player=")
        and not string.match(url, "Default%.aspx%?player=")
        and not string.match(url, "/Stats/Halo3/Default%.aspx%?player=") then
        return true
      else
        return false
      end
    else
      return false
    end
  end
  
end


wget.callbacks.get_urls = function(file, url, is_css, iri)
  local urls = {}
  local html = nil
        
  if string.match(url, "/Stats/GameStatsHalo3%.aspx%?gameguid=") then
    local customurl = string.gsub(url, "/Stats/GameStatsHalo3%.aspx%?gameguid=", "/Stats/GameFiles%.aspx%?guid=")
    if downloaded[customurl] ~= true and addedtolist[customurl] ~= true then
      table.insert(urls, { url=customurl })
    end
  end
  
  if item_type == "halo3file" then
    if string.match(url, "[^0-9]"..item_value.."[0-9][0-9]") then
      if not string.match(url, "[0-9]?"..item_value.."[0-9][0-9][0-9]") then
        html = read_file(html)
        
        for customurl in string.gmatch(html, '"(http[s]?://[^"]+)"') do
          if string.match(customurl, "[^0-9]"..item_value.."[0-9][0-9]")
            or string.match(customurl, "/javascript/")
            or string.match(customurl, "/base_css/")
            or string.match(customurl, "/images/")
            or string.match(customurl, "/Silverlight/")
            or string.match(customurl, "/App_Themes/")
            or string.match(customurl, "/WebResource%.axd")
            or string.match(customurl, "/emblem%.ashx")
            or string.match(customurl, "/GameFiles%.aspx")
            or string.match(customurl, "/gamestatscampaignhalo3%.aspx")
            or string.match(customurl, "/odstg%.aspx")
            or string.match(customurl, "/bprovideo/")
            or string.match(customurl, "/ScriptResource%.axd")
            or string.match(customurl, "/Screenshot%.ashx")
            or string.match(customurl, "silverlight%.dlservice%.microsoft%.com")
            or string.match(customurl, "/GameStatsHalo3%.aspx") then
            if not string.match(customurl, "[0-9]?"..item_value.."[0-9][0-9][0-9]")
              and not string.match(customurl, "PlayerStatsHalo3%.aspx%?player=")
              and not string.match(customurl, "/Stats/Halo3/Default%.aspx%?player=") then
              if downloaded[customurl] ~= true and addedtolist[customurl] ~= true then
                table.insert(urls, { url=customurl })
              end
            end
          end
        end
        for customurl in string.gmatch(html, '%((http[s]?://[^%)]+)%)') do
          if string.match(customurl, "[^0-9]"..item_value.."[0-9][0-9]")
            or string.match(customurl, "/javascript/")
            or string.match(customurl, "/base_css/")
            or string.match(customurl, "/images/")
            or string.match(customurl, "/Silverlight/")
            or string.match(customurl, "/App_Themes/")
            or string.match(customurl, "/WebResource%.axd")
            or string.match(customurl, "/emblem%.ashx")
            or string.match(customurl, "/GameFiles%.aspx")
            or string.match(customurl, "/gamestatscampaignhalo3%.aspx")
            or string.match(customurl, "/odstg%.aspx")
            or string.match(customurl, "/bprovideo/")
            or string.match(customurl, "/ScriptResource%.axd")
            or string.match(customurl, "/Screenshot%.ashx")
            or string.match(customurl, "silverlight%.dlservice%.microsoft%.com")
            or string.match(customurl, "/GameStatsHalo3%.aspx") then
            if not string.match(customurl, "[0-9]?"..item_value.."[0-9][0-9][0-9]")
              and not string.match(customurl, "PlayerStatsHalo3%.aspx%?player=")
              and not string.match(customurl, "/Stats/Halo3/Default%.aspx%?player=") then
              if downloaded[customurl] ~= true and addedtolist[customurl] ~= true then
                table.insert(urls, { url=customurl })
              end
            end
          end
        end
        for customurlnf in string.gmatch(html, '"(/[^"]+)"') do
          if string.match(customurlnf, "[^0-9]"..item_value.."[0-9][0-9]")
            or string.match(customurlnf, "/javascript/")
            or string.match(customurlnf, "/base_css/")
            or string.match(customurlnf, "/images/")
            or string.match(customurlnf, "/Silverlight/")
            or string.match(customurlnf, "/Stats/")
            or string.match(customurlnf, "/App_Themes/")
            or string.match(customurlnf, "/WebResource%.axd")
            or string.match(customurlnf, "/emblem%.ashx")
            or string.match(customurlnf, "/GameFiles%.aspx")
            or string.match(customurlnf, "/gamestatscampaignhalo3%.aspx")
            or string.match(customurlnf, "/odstg%.aspx")
            or string.match(customurlnf, "/bprovideo/")
            or string.match(customurlnf, "/ScriptResource%.axd")
            or string.match(customurlnf, "/Screenshot%.ashx")
            or string.match(customurlnf, "/GameStatsHalo3%.aspx") then
            if not string.match(customurlnf, "[0-9]?"..item_value.."[0-9][0-9][0-9]")
              and not string.match(customurl, "PlayerStatsHalo3%.aspx%?player=")
              and not string.match(customurl, "/Stats/Halo3/Default%.aspx%?player=")  then
              local base = "http://halo.bungie.net"
              local customurl = base..customurlnf
              if downloaded[customurl] ~= true and addedtolist[customurl] ~= true then
                table.insert(urls, { url=customurl })
              end
            end
          end
        end
      end
    end
  end
  
  
  return urls
end
  

wget.callbacks.httploop_result = function(url, err, http_stat)
  -- NEW for 2014: Slightly more verbose messages because people keep
  -- complaining that it's not moving or not working
  local status_code = http_stat["statcode"]
  
  url_count = url_count + 1
  io.stdout:write(url_count .. "=" .. status_code .. " " .. url["url"] .. ".  \n")
  io.stdout:flush()
  
  if (status_code >= 200 and status_code <= 399) or status_code == 403 then
    if string.match(url.url, "https://") then
      local newurl = string.gsub(url.url, "https://", "http://")
      downloaded[newurl] = true
    else
      downloaded[url.url] = true
    end
  end
  
  if status_code >= 500 or
    (status_code >= 400 and status_code ~= 404 and status_code ~= 403) then
    io.stdout:write("\nServer returned "..http_stat.statcode..". Sleeping.\n")
    io.stdout:flush()

    os.execute("sleep 1")

    tries = tries + 1

    if tries >= 20 then
      io.stdout:write("\nI give up...\n")
      io.stdout:flush()
      return wget.actions.ABORT
    else
      return wget.actions.CONTINUE
    end
  elseif status_code == 0 then
    io.stdout:write("\nServer returned "..http_stat.statcode..". Sleeping.\n")
    io.stdout:flush()

    os.execute("sleep 10")

    tries = tries + 1

    if tries >= 10 then
      io.stdout:write("\nI give up...\n")
      io.stdout:flush()
      return wget.actions.ABORT
    else
      return wget.actions.CONTINUE
    end
  end

  tries = 0

  -- We're okay; sleep a bit (if we have to) and continue
  -- local sleep_time = 0.1 * (math.random(75, 1000) / 100.0)
  local sleep_time = 0

  --  if string.match(url["host"], "cdn") or string.match(url["host"], "media") then
  --    -- We should be able to go fast on images since that's what a web browser does
  --    sleep_time = 0
  --  end

  if sleep_time > 0.001 then
    os.execute("sleep " .. sleep_time)
  end

  return wget.actions.NOTHING
end
