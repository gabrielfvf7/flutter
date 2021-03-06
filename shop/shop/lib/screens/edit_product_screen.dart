import 'package:flutter/material.dart';
import 'package:shop/providers/product.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _isLoading = false;
  var _initValues = {
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': '',
  };
  Product _editedProduct =
      Product(id: null, title: "", description: "", price: 0, imageUrl: "");

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': '',
        };
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

  Future<void> _saveForm() async {
    if (!_form.currentState.validate()) {
      return null;
    }
    _form.currentState.save();
    setState(() => _isLoading = true);
    if (_editedProduct.id != null) {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        return showDialog<Null>(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Error!"),
                  content: Text("Something went wrong"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Ok"),
                      onPressed: () => Navigator.of(ctx).pop(),
                    )
                  ],
                ));
      }
    }
    setState(() => _isLoading = false);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: _saveForm),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please provide a value";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) => _editedProduct = Product(
                        title: value,
                        price: _editedProduct.price,
                        description: _editedProduct.description,
                        id: _editedProduct.id,
                        isFavorite: _editedProduct.isFavorite,
                        imageUrl: _editedProduct.imageUrl,
                      ),
                    ),
                    TextFormField(
                        initialValue: _initValues['price'],
                        decoration: InputDecoration(labelText: 'Price'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter a price";
                          }
                          if (double.tryParse(value) == null) {
                            return "Please enter a valid number";
                          }
                          if (double.parse(value) <= 0) {
                            return "Please enter a number greater than zero";
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                        onSaved: (value) => _editedProduct = Product(
                              title: _editedProduct.title,
                              price: double.parse(value),
                              description: _editedProduct.description,
                              id: _editedProduct.id,
                              isFavorite: _editedProduct.isFavorite,
                              imageUrl: _editedProduct.imageUrl,
                            )),
                    TextFormField(
                        initialValue: _initValues['description'],
                        decoration: InputDecoration(labelText: 'Description'),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        focusNode: _descriptionFocusNode,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter a description";
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) => FocusScope.of(context)
                            .requestFocus(_imageUrlFocusNode),
                        onSaved: (value) => _editedProduct = Product(
                              title: _editedProduct.title,
                              price: _editedProduct.price,
                              description: value,
                              id: _editedProduct.id,
                              isFavorite: _editedProduct.isFavorite,
                              imageUrl: _editedProduct.imageUrl,
                            )),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Enter a URL')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Image URL'),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _imageUrlController,
                              focusNode: _imageUrlFocusNode,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please enter an image URL";
                                }
                                if (!value.startsWith("http") &&
                                    !value.startsWith("https")) {
                                  return "Please enter an image URL that starts with http/https";
                                }
                                if (!value.endsWith(".png") &&
                                    !value.endsWith(".jpg") &&
                                    !value.endsWith(".jpeg")) {
                                  return "Please enter a valid image url";
                                }
                                return null;
                              },
                              onFieldSubmitted: (_) {
                                _updateImageUrl();
                                _saveForm();
                              },
                              onSaved: (value) => _editedProduct = Product(
                                    title: _editedProduct.title,
                                    price: _editedProduct.price,
                                    description: _editedProduct.description,
                                    id: _editedProduct.id,
                                    isFavorite: _editedProduct.isFavorite,
                                    imageUrl: value,
                                  )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
