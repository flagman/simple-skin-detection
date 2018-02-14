# Unsupervised Skin Tone Estimation/Segmentation

### General

Estimates skin tone based on an image of a person and at the same time it does a very rough segmentation of skin based on a pixel-wise classifier. If your primary goal is a nice clean segmentation, I would recommend other methods, but for the purpose of estimating skin tone it works okay.

The algorithm is based on [this paper here] and consists of two main steps

  - Foreground and background separation using Otsu's Binarization
  - Pixel-wise skin classifier based on HSV and YCrCb colorspaces

Implemented in MATLAB and OpenCV (Python)

### Sample Results
  ![](images/sample_results.jpg?raw=true)

### License
MIT,  see LICENSE.md for details


   [this paper here]: <http://www.eleco.org.tr/openconf_2017/modules/request.php?module=oc_proceedings&action=view.php&id=248&file=1/248.pdf&a=Accept+as+Lecture>
