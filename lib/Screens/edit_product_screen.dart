import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/categories.dart';
import 'package:shop_app/Providers/product.dart';
import 'package:shop_app/Providers/products.dart';
import 'package:shop_app/Widgets/rounded_button.dart';
import 'package:shop_app/constants.dart';

class EditProductScreen extends StatefulWidget {
  static const String id = 'EditProductScreen';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  var dropValue = '';

  var _isInit = true;
  String url = '';

  final _form = GlobalKey<FormState>();

  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
    'available': '',
    'category': ''
  };

  var _isLoading = false;

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    super.dispose();
  }

  @override
  void initState() {
    dropValue = 'Men\'s Fashion';
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findByID(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': '',
          'available': _editedProduct.available.toString(),
          'category': _editedProduct.category
        };
        dropValue = _initValues['category'] == null
            ? 'Men\'s Fashion'
            : _initValues['category'];
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<Categories>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [IconButton(icon: Icon(Icons.save), onPressed: _saveform)],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(6.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initValues['title'],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: validator,
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            description: _editedProduct.description,
                            imageUrl: _editedProduct.imageUrl,
                            price: _editedProduct.price,
                            isFavorite: _editedProduct.isFavorite,
                            title: value);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: priceValidator,
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            description: _editedProduct.description,
                            imageUrl: _editedProduct.imageUrl,
                            price: value.isEmpty ? null : double.parse(value),
                            isFavorite: _editedProduct.isFavorite,
                            title: _editedProduct.title,
                            available: _editedProduct.available,
                            category: dropValue);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: descriptionValidator,
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            description: value,
                            imageUrl: _editedProduct.imageUrl,
                            price: _editedProduct.price,
                            isFavorite: _editedProduct.isFavorite,
                            title: _editedProduct.title,
                            category: dropValue);
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: url.isEmpty
                              ? Text('Enter a URL')
                              : FittedBox(
                                  child: Image.network(url, fit: BoxFit.cover),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: imageValidator,
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            onFieldSubmitted: (value) {
                              setState(() {
                                url = value;
                              });
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                  id: _editedProduct.id,
                                  description: _editedProduct.description,
                                  imageUrl: value,
                                  price: _editedProduct.price,
                                  isFavorite: _editedProduct.isFavorite,
                                  title: _editedProduct.title,
                                  category: dropValue);
                            },
                          ),
                        )
                      ],
                    ),
                    TextFormField(
                      initialValue: _initValues['available'],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: priceValidator,
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                      ),
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            description: _editedProduct.description,
                            imageUrl: _editedProduct.imageUrl,
                            price: _editedProduct.price,
                            isFavorite: _editedProduct.isFavorite,
                            title: _editedProduct.title,
                            available: int.parse(value),
                            category: dropValue);
                      },
                    ),
                    DropdownButton(
                      value: dropValue,
                      items: categories.dropdownList,
                      onChanged: (value) {
                        setState(() {
                          dropValue = value;
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              description: _editedProduct.description,
                              imageUrl: _editedProduct.imageUrl,
                              price: _editedProduct.price,
                              isFavorite: _editedProduct.isFavorite,
                              title: _editedProduct.title,
                              available: _editedProduct.available,
                              category: dropValue);
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedButton(
                      title: 'Save',
                      color: Colors.deepOrange,
                      onPressed: () {
                        _saveform();
                      },
                    )
                  ],
                ),
              ),
            ),
    );
  }

  void _saveform() async {
    final isValid = _form.currentState.validate();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      _form.currentState.save();
      if (_editedProduct.id != null) {
        await Provider.of<Products>(context, listen: false)
            .updateProduct(_editedProduct.id, _editedProduct);
        Navigator.of(context).pop();
      } else {
        try {
          await Provider.of<Products>(context, listen: false)
              .addProduct(_editedProduct);
        } catch (ex) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('An error occurred!'),
                    content: Text('Somthing went wrong'),
                    actions: [
                      MaterialButton(
                        child: Text('Okay'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ));
        }
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }
  }
}
