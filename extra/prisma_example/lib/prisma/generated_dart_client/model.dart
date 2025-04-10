// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:orm/orm.dart' as _i3;

import 'model.dart' as _i1;
import 'prisma.dart' as _i2;

class Category {
  const Category({
    this.id,
    this.name,
    this.description,
    this.parentCategoryId,
    this.createdAt,
    this.updatedAt,
    this.parentCategory,
    this.subcategories,
    this.products,
    this.$count,
  });

  factory Category.fromJson(Map json) => Category(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        parentCategoryId: json['parentCategoryId'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
        parentCategory: json['parentCategory'] is Map
            ? _i1.Category.fromJson(json['parentCategory'])
            : null,
        subcategories: (json['subcategories'] as Iterable?)
            ?.map((json) => _i1.Category.fromJson(json)),
        products: (json['products'] as Iterable?)
            ?.map((json) => _i1.ProductCategory.fromJson(json)),
        $count: json['_count'] is Map
            ? _i2.CategoryCountOutputType.fromJson(json['_count'])
            : null,
      );

  final int? id;

  final String? name;

  final String? description;

  final int? parentCategoryId;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final _i1.Category? parentCategory;

  final Iterable<_i1.Category>? subcategories;

  final Iterable<_i1.ProductCategory>? products;

  final _i2.CategoryCountOutputType? $count;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'parentCategoryId': parentCategoryId,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'parentCategory': parentCategory?.toJson(),
        'subcategories': subcategories?.map((e) => e.toJson()),
        'products': products?.map((e) => e.toJson()),
        '_count': $count?.toJson(),
      };
}

class ProductCategory {
  const ProductCategory({
    this.productId,
    this.categoryId,
    this.product,
    this.category,
  });

  factory ProductCategory.fromJson(Map json) => ProductCategory(
        productId: json['productId'],
        categoryId: json['categoryId'],
        product: json['product'] is Map
            ? _i1.Product.fromJson(json['product'])
            : null,
        category: json['category'] is Map
            ? _i1.Category.fromJson(json['category'])
            : null,
      );

  final int? productId;

  final int? categoryId;

  final _i1.Product? product;

  final _i1.Category? category;

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'categoryId': categoryId,
        'product': product?.toJson(),
        'category': category?.toJson(),
      };
}

class ProductImage {
  const ProductImage({
    this.id,
    this.productId,
    this.imageUrl,
    this.isPrimary,
    this.displayOrder,
    this.createdAt,
    this.product,
  });

  factory ProductImage.fromJson(Map json) => ProductImage(
        id: json['id'],
        productId: json['productId'],
        imageUrl: json['imageUrl'],
        isPrimary: json['isPrimary'],
        displayOrder: json['displayOrder'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        product: json['product'] is Map
            ? _i1.Product.fromJson(json['product'])
            : null,
      );

  final int? id;

  final int? productId;

  final String? imageUrl;

  final bool? isPrimary;

  final int? displayOrder;

  final DateTime? createdAt;

  final _i1.Product? product;

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'imageUrl': imageUrl,
        'isPrimary': isPrimary,
        'displayOrder': displayOrder,
        'createdAt': createdAt?.toIso8601String(),
        'product': product?.toJson(),
      };
}

class Cart {
  const Cart({
    this.id,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.items,
    this.$count,
  });

  factory Cart.fromJson(Map json) => Cart(
        id: json['id'],
        userId: json['userId'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
        user: json['user'] is Map ? _i1.User.fromJson(json['user']) : null,
        items: (json['items'] as Iterable?)
            ?.map((json) => _i1.CartItem.fromJson(json)),
        $count: json['_count'] is Map
            ? _i2.CartCountOutputType.fromJson(json['_count'])
            : null,
      );

  final int? id;

  final int? userId;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final _i1.User? user;

  final Iterable<_i1.CartItem>? items;

  final _i2.CartCountOutputType? $count;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'user': user?.toJson(),
        'items': items?.map((e) => e.toJson()),
        '_count': $count?.toJson(),
      };
}

class CartItem {
  const CartItem({
    this.id,
    this.cartId,
    this.productId,
    this.quantity,
    this.priceAtAddition,
    this.addedAt,
    this.cart,
    this.product,
  });

  factory CartItem.fromJson(Map json) => CartItem(
        id: json['id'],
        cartId: json['cartId'],
        productId: json['productId'],
        quantity: json['quantity'],
        priceAtAddition: json['priceAtAddition'],
        addedAt: switch (json['addedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['addedAt']
        },
        cart: json['cart'] is Map ? _i1.Cart.fromJson(json['cart']) : null,
        product: json['product'] is Map
            ? _i1.Product.fromJson(json['product'])
            : null,
      );

  final int? id;

  final int? cartId;

  final int? productId;

  final int? quantity;

  final _i3.Decimal? priceAtAddition;

  final DateTime? addedAt;

  final _i1.Cart? cart;

  final _i1.Product? product;

  Map<String, dynamic> toJson() => {
        'id': id,
        'cartId': cartId,
        'productId': productId,
        'quantity': quantity,
        'priceAtAddition': priceAtAddition,
        'addedAt': addedAt?.toIso8601String(),
        'cart': cart?.toJson(),
        'product': product?.toJson(),
      };
}

class Review {
  const Review({
    this.id,
    this.productId,
    this.userId,
    this.rating,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.user,
  });

  factory Review.fromJson(Map json) => Review(
        id: json['id'],
        productId: json['productId'],
        userId: json['userId'],
        rating: json['rating'],
        comment: json['comment'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
        product: json['product'] is Map
            ? _i1.Product.fromJson(json['product'])
            : null,
        user: json['user'] is Map ? _i1.User.fromJson(json['user']) : null,
      );

  final int? id;

  final int? productId;

  final int? userId;

  final int? rating;

  final String? comment;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final _i1.Product? product;

  final _i1.User? user;

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'userId': userId,
        'rating': rating,
        'comment': comment,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'product': product?.toJson(),
        'user': user?.toJson(),
      };
}

class Wishlist {
  const Wishlist({
    this.id,
    this.userId,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.items,
    this.$count,
  });

  factory Wishlist.fromJson(Map json) => Wishlist(
        id: json['id'],
        userId: json['userId'],
        name: json['name'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
        user: json['user'] is Map ? _i1.User.fromJson(json['user']) : null,
        items: (json['items'] as Iterable?)
            ?.map((json) => _i1.WishlistItem.fromJson(json)),
        $count: json['_count'] is Map
            ? _i2.WishlistCountOutputType.fromJson(json['_count'])
            : null,
      );

  final int? id;

  final int? userId;

  final String? name;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final _i1.User? user;

  final Iterable<_i1.WishlistItem>? items;

  final _i2.WishlistCountOutputType? $count;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'name': name,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'user': user?.toJson(),
        'items': items?.map((e) => e.toJson()),
        '_count': $count?.toJson(),
      };
}

class WishlistItem {
  const WishlistItem({
    this.wishlistId,
    this.productId,
    this.addedAt,
    this.wishlist,
    this.product,
  });

  factory WishlistItem.fromJson(Map json) => WishlistItem(
        wishlistId: json['wishlistId'],
        productId: json['productId'],
        addedAt: switch (json['addedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['addedAt']
        },
        wishlist: json['wishlist'] is Map
            ? _i1.Wishlist.fromJson(json['wishlist'])
            : null,
        product: json['product'] is Map
            ? _i1.Product.fromJson(json['product'])
            : null,
      );

  final int? wishlistId;

  final int? productId;

  final DateTime? addedAt;

  final _i1.Wishlist? wishlist;

  final _i1.Product? product;

  Map<String, dynamic> toJson() => {
        'wishlistId': wishlistId,
        'productId': productId,
        'addedAt': addedAt?.toIso8601String(),
        'wishlist': wishlist?.toJson(),
        'product': product?.toJson(),
      };
}

class Discount {
  const Discount({
    this.id,
    this.code,
    this.description,
    this.amount,
    this.discountType,
    this.usageLimit,
    this.timesUsed,
    this.validFrom,
    this.validTo,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.products,
    this.$count,
  });

  factory Discount.fromJson(Map json) => Discount(
        id: json['id'],
        code: json['code'],
        description: json['description'],
        amount: json['amount'],
        discountType: json['discountType'],
        usageLimit: json['usageLimit'],
        timesUsed: json['timesUsed'],
        validFrom: switch (json['validFrom']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['validFrom']
        },
        validTo: switch (json['validTo']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['validTo']
        },
        isActive: json['isActive'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
        products: (json['products'] as Iterable?)
            ?.map((json) => _i1.ProductDiscount.fromJson(json)),
        $count: json['_count'] is Map
            ? _i2.DiscountCountOutputType.fromJson(json['_count'])
            : null,
      );

  final int? id;

  final String? code;

  final String? description;

  final _i3.Decimal? amount;

  final String? discountType;

  final int? usageLimit;

  final int? timesUsed;

  final DateTime? validFrom;

  final DateTime? validTo;

  final bool? isActive;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final Iterable<_i1.ProductDiscount>? products;

  final _i2.DiscountCountOutputType? $count;

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'description': description,
        'amount': amount,
        'discountType': discountType,
        'usageLimit': usageLimit,
        'timesUsed': timesUsed,
        'validFrom': validFrom?.toIso8601String(),
        'validTo': validTo?.toIso8601String(),
        'isActive': isActive,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'products': products?.map((e) => e.toJson()),
        '_count': $count?.toJson(),
      };
}

class ProductDiscount {
  const ProductDiscount({
    this.productId,
    this.discountId,
    this.product,
    this.discount,
  });

  factory ProductDiscount.fromJson(Map json) => ProductDiscount(
        productId: json['productId'],
        discountId: json['discountId'],
        product: json['product'] is Map
            ? _i1.Product.fromJson(json['product'])
            : null,
        discount: json['discount'] is Map
            ? _i1.Discount.fromJson(json['discount'])
            : null,
      );

  final int? productId;

  final int? discountId;

  final _i1.Product? product;

  final _i1.Discount? discount;

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'discountId': discountId,
        'product': product?.toJson(),
        'discount': discount?.toJson(),
      };
}

class Product {
  const Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.stockQuantity,
    this.sku,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.categories,
    this.images,
    this.cartItems,
    this.orderItems,
    this.reviews,
    this.wishlistItems,
    this.discounts,
    this.$count,
  });

  factory Product.fromJson(Map json) => Product(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        stockQuantity: json['stockQuantity'],
        sku: json['sku'],
        isActive: json['isActive'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
        categories: (json['categories'] as Iterable?)
            ?.map((json) => _i1.ProductCategory.fromJson(json)),
        images: (json['images'] as Iterable?)
            ?.map((json) => _i1.ProductImage.fromJson(json)),
        cartItems: (json['cartItems'] as Iterable?)
            ?.map((json) => _i1.CartItem.fromJson(json)),
        orderItems: (json['orderItems'] as Iterable?)
            ?.map((json) => _i1.OrderItem.fromJson(json)),
        reviews: (json['reviews'] as Iterable?)
            ?.map((json) => _i1.Review.fromJson(json)),
        wishlistItems: (json['wishlistItems'] as Iterable?)
            ?.map((json) => _i1.WishlistItem.fromJson(json)),
        discounts: (json['discounts'] as Iterable?)
            ?.map((json) => _i1.ProductDiscount.fromJson(json)),
        $count: json['_count'] is Map
            ? _i2.ProductCountOutputType.fromJson(json['_count'])
            : null,
      );

  final int? id;

  final String? name;

  final String? description;

  final _i3.Decimal? price;

  final int? stockQuantity;

  final String? sku;

  final bool? isActive;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final Iterable<_i1.ProductCategory>? categories;

  final Iterable<_i1.ProductImage>? images;

  final Iterable<_i1.CartItem>? cartItems;

  final Iterable<_i1.OrderItem>? orderItems;

  final Iterable<_i1.Review>? reviews;

  final Iterable<_i1.WishlistItem>? wishlistItems;

  final Iterable<_i1.ProductDiscount>? discounts;

  final _i2.ProductCountOutputType? $count;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'stockQuantity': stockQuantity,
        'sku': sku,
        'isActive': isActive,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'categories': categories?.map((e) => e.toJson()),
        'images': images?.map((e) => e.toJson()),
        'cartItems': cartItems?.map((e) => e.toJson()),
        'orderItems': orderItems?.map((e) => e.toJson()),
        'reviews': reviews?.map((e) => e.toJson()),
        'wishlistItems': wishlistItems?.map((e) => e.toJson()),
        'discounts': discounts?.map((e) => e.toJson()),
        '_count': $count?.toJson(),
      };
}

class OrderItem {
  const OrderItem({
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.priceAtPurchase,
    this.subtotal,
    this.createdAt,
    this.order,
    this.product,
  });

  factory OrderItem.fromJson(Map json) => OrderItem(
        id: json['id'],
        orderId: json['orderId'],
        productId: json['productId'],
        quantity: json['quantity'],
        priceAtPurchase: json['priceAtPurchase'],
        subtotal: json['subtotal'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        order: json['order'] is Map ? _i1.Order.fromJson(json['order']) : null,
        product: json['product'] is Map
            ? _i1.Product.fromJson(json['product'])
            : null,
      );

  final int? id;

  final int? orderId;

  final int? productId;

  final int? quantity;

  final _i3.Decimal? priceAtPurchase;

  final _i3.Decimal? subtotal;

  final DateTime? createdAt;

  final _i1.Order? order;

  final _i1.Product? product;

  Map<String, dynamic> toJson() => {
        'id': id,
        'orderId': orderId,
        'productId': productId,
        'quantity': quantity,
        'priceAtPurchase': priceAtPurchase,
        'subtotal': subtotal,
        'createdAt': createdAt?.toIso8601String(),
        'order': order?.toJson(),
        'product': product?.toJson(),
      };
}

class Payment {
  const Payment({
    this.id,
    this.orderId,
    this.paymentMethod,
    this.transactionId,
    this.amount,
    this.status,
    this.paymentDate,
    this.order,
  });

  factory Payment.fromJson(Map json) => Payment(
        id: json['id'],
        orderId: json['orderId'],
        paymentMethod: json['paymentMethod'],
        transactionId: json['transactionId'],
        amount: json['amount'],
        status: json['status'],
        paymentDate: switch (json['paymentDate']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['paymentDate']
        },
        order: json['order'] is Map ? _i1.Order.fromJson(json['order']) : null,
      );

  final int? id;

  final int? orderId;

  final String? paymentMethod;

  final String? transactionId;

  final _i3.Decimal? amount;

  final String? status;

  final DateTime? paymentDate;

  final _i1.Order? order;

  Map<String, dynamic> toJson() => {
        'id': id,
        'orderId': orderId,
        'paymentMethod': paymentMethod,
        'transactionId': transactionId,
        'amount': amount,
        'status': status,
        'paymentDate': paymentDate?.toIso8601String(),
        'order': order?.toJson(),
      };
}

class Order {
  const Order({
    this.id,
    this.userId,
    this.shippingAddressId,
    this.billingAddressId,
    this.subtotal,
    this.tax,
    this.shippingCost,
    this.totalAmount,
    this.status,
    this.paymentStatus,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.shippingAddress,
    this.billingAddress,
    this.items,
    this.payments,
    this.$count,
  });

  factory Order.fromJson(Map json) => Order(
        id: json['id'],
        userId: json['userId'],
        shippingAddressId: json['shippingAddressId'],
        billingAddressId: json['billingAddressId'],
        subtotal: json['subtotal'],
        tax: json['tax'],
        shippingCost: json['shippingCost'],
        totalAmount: json['totalAmount'],
        status: json['status'],
        paymentStatus: json['paymentStatus'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
        user: json['user'] is Map ? _i1.User.fromJson(json['user']) : null,
        shippingAddress: json['shippingAddress'] is Map
            ? _i1.Address.fromJson(json['shippingAddress'])
            : null,
        billingAddress: json['billingAddress'] is Map
            ? _i1.Address.fromJson(json['billingAddress'])
            : null,
        items: (json['items'] as Iterable?)
            ?.map((json) => _i1.OrderItem.fromJson(json)),
        payments: (json['payments'] as Iterable?)
            ?.map((json) => _i1.Payment.fromJson(json)),
        $count: json['_count'] is Map
            ? _i2.OrderCountOutputType.fromJson(json['_count'])
            : null,
      );

  final int? id;

  final int? userId;

  final int? shippingAddressId;

  final int? billingAddressId;

  final _i3.Decimal? subtotal;

  final _i3.Decimal? tax;

  final _i3.Decimal? shippingCost;

  final _i3.Decimal? totalAmount;

  final String? status;

  final String? paymentStatus;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final _i1.User? user;

  final _i1.Address? shippingAddress;

  final _i1.Address? billingAddress;

  final Iterable<_i1.OrderItem>? items;

  final Iterable<_i1.Payment>? payments;

  final _i2.OrderCountOutputType? $count;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'shippingAddressId': shippingAddressId,
        'billingAddressId': billingAddressId,
        'subtotal': subtotal,
        'tax': tax,
        'shippingCost': shippingCost,
        'totalAmount': totalAmount,
        'status': status,
        'paymentStatus': paymentStatus,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'user': user?.toJson(),
        'shippingAddress': shippingAddress?.toJson(),
        'billingAddress': billingAddress?.toJson(),
        'items': items?.map((e) => e.toJson()),
        'payments': payments?.map((e) => e.toJson()),
        '_count': $count?.toJson(),
      };
}

class Address {
  const Address({
    this.id,
    this.userId,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.shippingOrders,
    this.billingOrders,
    this.$count,
  });

  factory Address.fromJson(Map json) => Address(
        id: json['id'],
        userId: json['userId'],
        addressLine1: json['addressLine1'],
        addressLine2: json['addressLine2'],
        city: json['city'],
        state: json['state'],
        postalCode: json['postalCode'],
        country: json['country'],
        isDefault: json['isDefault'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
        user: json['user'] is Map ? _i1.User.fromJson(json['user']) : null,
        shippingOrders: (json['shippingOrders'] as Iterable?)
            ?.map((json) => _i1.Order.fromJson(json)),
        billingOrders: (json['billingOrders'] as Iterable?)
            ?.map((json) => _i1.Order.fromJson(json)),
        $count: json['_count'] is Map
            ? _i2.AddressCountOutputType.fromJson(json['_count'])
            : null,
      );

  final int? id;

  final int? userId;

  final String? addressLine1;

  final String? addressLine2;

  final String? city;

  final String? state;

  final String? postalCode;

  final String? country;

  final bool? isDefault;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final _i1.User? user;

  final Iterable<_i1.Order>? shippingOrders;

  final Iterable<_i1.Order>? billingOrders;

  final _i2.AddressCountOutputType? $count;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'addressLine1': addressLine1,
        'addressLine2': addressLine2,
        'city': city,
        'state': state,
        'postalCode': postalCode,
        'country': country,
        'isDefault': isDefault,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'user': user?.toJson(),
        'shippingOrders': shippingOrders?.map((e) => e.toJson()),
        'billingOrders': billingOrders?.map((e) => e.toJson()),
        '_count': $count?.toJson(),
      };
}

class User {
  const User({
    this.id,
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.addresses,
    this.carts,
    this.orders,
    this.reviews,
    this.wishlists,
    this.$count,
  });

  factory User.fromJson(Map json) => User(
        id: json['id'],
        email: json['email'],
        password: json['password'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        phone: json['phone'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
        addresses: (json['addresses'] as Iterable?)
            ?.map((json) => _i1.Address.fromJson(json)),
        carts: (json['carts'] as Iterable?)
            ?.map((json) => _i1.Cart.fromJson(json)),
        orders: (json['orders'] as Iterable?)
            ?.map((json) => _i1.Order.fromJson(json)),
        reviews: (json['reviews'] as Iterable?)
            ?.map((json) => _i1.Review.fromJson(json)),
        wishlists: (json['wishlists'] as Iterable?)
            ?.map((json) => _i1.Wishlist.fromJson(json)),
        $count: json['_count'] is Map
            ? _i2.UserCountOutputType.fromJson(json['_count'])
            : null,
      );

  final int? id;

  final String? email;

  final String? password;

  final String? firstName;

  final String? lastName;

  final String? phone;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final Iterable<_i1.Address>? addresses;

  final Iterable<_i1.Cart>? carts;

  final Iterable<_i1.Order>? orders;

  final Iterable<_i1.Review>? reviews;

  final Iterable<_i1.Wishlist>? wishlists;

  final _i2.UserCountOutputType? $count;

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'addresses': addresses?.map((e) => e.toJson()),
        'carts': carts?.map((e) => e.toJson()),
        'orders': orders?.map((e) => e.toJson()),
        'reviews': reviews?.map((e) => e.toJson()),
        'wishlists': wishlists?.map((e) => e.toJson()),
        '_count': $count?.toJson(),
      };
}

class CreateManyUserAndReturnOutputType {
  const CreateManyUserAndReturnOutputType({
    this.id,
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  factory CreateManyUserAndReturnOutputType.fromJson(Map json) =>
      CreateManyUserAndReturnOutputType(
        id: json['id'],
        email: json['email'],
        password: json['password'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        phone: json['phone'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
      );

  final int? id;

  final String? email;

  final String? password;

  final String? firstName;

  final String? lastName;

  final String? phone;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}

class UpdateManyUserAndReturnOutputType {
  const UpdateManyUserAndReturnOutputType({
    this.id,
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  factory UpdateManyUserAndReturnOutputType.fromJson(Map json) =>
      UpdateManyUserAndReturnOutputType(
        id: json['id'],
        email: json['email'],
        password: json['password'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        phone: json['phone'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
      );

  final int? id;

  final String? email;

  final String? password;

  final String? firstName;

  final String? lastName;

  final String? phone;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}

class CreateManyAddressAndReturnOutputType {
  const CreateManyAddressAndReturnOutputType({
    this.id,
    this.userId,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory CreateManyAddressAndReturnOutputType.fromJson(Map json) =>
      CreateManyAddressAndReturnOutputType(
        id: json['id'],
        userId: json['userId'],
        addressLine1: json['addressLine1'],
        addressLine2: json['addressLine2'],
        city: json['city'],
        state: json['state'],
        postalCode: json['postalCode'],
        country: json['country'],
        isDefault: json['isDefault'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
        user: json['user'] is Map ? _i1.User.fromJson(json['user']) : null,
      );

  final int? id;

  final int? userId;

  final String? addressLine1;

  final String? addressLine2;

  final String? city;

  final String? state;

  final String? postalCode;

  final String? country;

  final bool? isDefault;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final _i1.User? user;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'addressLine1': addressLine1,
        'addressLine2': addressLine2,
        'city': city,
        'state': state,
        'postalCode': postalCode,
        'country': country,
        'isDefault': isDefault,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'user': user?.toJson(),
      };
}

class UpdateManyAddressAndReturnOutputType {
  const UpdateManyAddressAndReturnOutputType({
    this.id,
    this.userId,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory UpdateManyAddressAndReturnOutputType.fromJson(Map json) =>
      UpdateManyAddressAndReturnOutputType(
        id: json['id'],
        userId: json['userId'],
        addressLine1: json['addressLine1'],
        addressLine2: json['addressLine2'],
        city: json['city'],
        state: json['state'],
        postalCode: json['postalCode'],
        country: json['country'],
        isDefault: json['isDefault'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
        user: json['user'] is Map ? _i1.User.fromJson(json['user']) : null,
      );

  final int? id;

  final int? userId;

  final String? addressLine1;

  final String? addressLine2;

  final String? city;

  final String? state;

  final String? postalCode;

  final String? country;

  final bool? isDefault;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final _i1.User? user;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'addressLine1': addressLine1,
        'addressLine2': addressLine2,
        'city': city,
        'state': state,
        'postalCode': postalCode,
        'country': country,
        'isDefault': isDefault,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'user': user?.toJson(),
      };
}

class CreateManyCategoryAndReturnOutputType {
  const CreateManyCategoryAndReturnOutputType({
    this.id,
    this.name,
    this.description,
    this.parentCategoryId,
    this.createdAt,
    this.updatedAt,
    this.parentCategory,
  });

  factory CreateManyCategoryAndReturnOutputType.fromJson(Map json) =>
      CreateManyCategoryAndReturnOutputType(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        parentCategoryId: json['parentCategoryId'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
        parentCategory: json['parentCategory'] is Map
            ? _i1.Category.fromJson(json['parentCategory'])
            : null,
      );

  final int? id;

  final String? name;

  final String? description;

  final int? parentCategoryId;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final _i1.Category? parentCategory;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'parentCategoryId': parentCategoryId,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'parentCategory': parentCategory?.toJson(),
      };
}

class UpdateManyCategoryAndReturnOutputType {
  const UpdateManyCategoryAndReturnOutputType({
    this.id,
    this.name,
    this.description,
    this.parentCategoryId,
    this.createdAt,
    this.updatedAt,
    this.parentCategory,
  });

  factory UpdateManyCategoryAndReturnOutputType.fromJson(Map json) =>
      UpdateManyCategoryAndReturnOutputType(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        parentCategoryId: json['parentCategoryId'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
        parentCategory: json['parentCategory'] is Map
            ? _i1.Category.fromJson(json['parentCategory'])
            : null,
      );

  final int? id;

  final String? name;

  final String? description;

  final int? parentCategoryId;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final _i1.Category? parentCategory;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'parentCategoryId': parentCategoryId,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'parentCategory': parentCategory?.toJson(),
      };
}

class CreateManyProductAndReturnOutputType {
  const CreateManyProductAndReturnOutputType({
    this.id,
    this.name,
    this.description,
    this.price,
    this.stockQuantity,
    this.sku,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory CreateManyProductAndReturnOutputType.fromJson(Map json) =>
      CreateManyProductAndReturnOutputType(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        stockQuantity: json['stockQuantity'],
        sku: json['sku'],
        isActive: json['isActive'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
      );

  final int? id;

  final String? name;

  final String? description;

  final _i3.Decimal? price;

  final int? stockQuantity;

  final String? sku;

  final bool? isActive;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'stockQuantity': stockQuantity,
        'sku': sku,
        'isActive': isActive,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}

class UpdateManyProductAndReturnOutputType {
  const UpdateManyProductAndReturnOutputType({
    this.id,
    this.name,
    this.description,
    this.price,
    this.stockQuantity,
    this.sku,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory UpdateManyProductAndReturnOutputType.fromJson(Map json) =>
      UpdateManyProductAndReturnOutputType(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        stockQuantity: json['stockQuantity'],
        sku: json['sku'],
        isActive: json['isActive'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
      );

  final int? id;

  final String? name;

  final String? description;

  final _i3.Decimal? price;

  final int? stockQuantity;

  final String? sku;

  final bool? isActive;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'stockQuantity': stockQuantity,
        'sku': sku,
        'isActive': isActive,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}

class CreateManyProductCategoryAndReturnOutputType {
  const CreateManyProductCategoryAndReturnOutputType({
    this.productId,
    this.categoryId,
    this.product,
    this.category,
  });

  factory CreateManyProductCategoryAndReturnOutputType.fromJson(Map json) =>
      CreateManyProductCategoryAndReturnOutputType(
        productId: json['productId'],
        categoryId: json['categoryId'],
        product: json['product'] is Map
            ? _i1.Product.fromJson(json['product'])
            : null,
        category: json['category'] is Map
            ? _i1.Category.fromJson(json['category'])
            : null,
      );

  final int? productId;

  final int? categoryId;

  final _i1.Product? product;

  final _i1.Category? category;

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'categoryId': categoryId,
        'product': product?.toJson(),
        'category': category?.toJson(),
      };
}

class UpdateManyProductCategoryAndReturnOutputType {
  const UpdateManyProductCategoryAndReturnOutputType({
    this.productId,
    this.categoryId,
    this.product,
    this.category,
  });

  factory UpdateManyProductCategoryAndReturnOutputType.fromJson(Map json) =>
      UpdateManyProductCategoryAndReturnOutputType(
        productId: json['productId'],
        categoryId: json['categoryId'],
        product: json['product'] is Map
            ? _i1.Product.fromJson(json['product'])
            : null,
        category: json['category'] is Map
            ? _i1.Category.fromJson(json['category'])
            : null,
      );

  final int? productId;

  final int? categoryId;

  final _i1.Product? product;

  final _i1.Category? category;

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'categoryId': categoryId,
        'product': product?.toJson(),
        'category': category?.toJson(),
      };
}

class CreateManyProductImageAndReturnOutputType {
  const CreateManyProductImageAndReturnOutputType({
    this.id,
    this.productId,
    this.imageUrl,
    this.isPrimary,
    this.displayOrder,
    this.createdAt,
    this.product,
  });

  factory CreateManyProductImageAndReturnOutputType.fromJson(Map json) =>
      CreateManyProductImageAndReturnOutputType(
        id: json['id'],
        productId: json['productId'],
        imageUrl: json['imageUrl'],
        isPrimary: json['isPrimary'],
        displayOrder: json['displayOrder'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        product: json['product'] is Map
            ? _i1.Product.fromJson(json['product'])
            : null,
      );

  final int? id;

  final int? productId;

  final String? imageUrl;

  final bool? isPrimary;

  final int? displayOrder;

  final DateTime? createdAt;

  final _i1.Product? product;

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'imageUrl': imageUrl,
        'isPrimary': isPrimary,
        'displayOrder': displayOrder,
        'createdAt': createdAt?.toIso8601String(),
        'product': product?.toJson(),
      };
}

class UpdateManyProductImageAndReturnOutputType {
  const UpdateManyProductImageAndReturnOutputType({
    this.id,
    this.productId,
    this.imageUrl,
    this.isPrimary,
    this.displayOrder,
    this.createdAt,
    this.product,
  });

  factory UpdateManyProductImageAndReturnOutputType.fromJson(Map json) =>
      UpdateManyProductImageAndReturnOutputType(
        id: json['id'],
        productId: json['productId'],
        imageUrl: json['imageUrl'],
        isPrimary: json['isPrimary'],
        displayOrder: json['displayOrder'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        product: json['product'] is Map
            ? _i1.Product.fromJson(json['product'])
            : null,
      );

  final int? id;

  final int? productId;

  final String? imageUrl;

  final bool? isPrimary;

  final int? displayOrder;

  final DateTime? createdAt;

  final _i1.Product? product;

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'imageUrl': imageUrl,
        'isPrimary': isPrimary,
        'displayOrder': displayOrder,
        'createdAt': createdAt?.toIso8601String(),
        'product': product?.toJson(),
      };
}

class CreateManyCartAndReturnOutputType {
  const CreateManyCartAndReturnOutputType({
    this.id,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory CreateManyCartAndReturnOutputType.fromJson(Map json) =>
      CreateManyCartAndReturnOutputType(
        id: json['id'],
        userId: json['userId'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
        user: json['user'] is Map ? _i1.User.fromJson(json['user']) : null,
      );

  final int? id;

  final int? userId;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final _i1.User? user;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'user': user?.toJson(),
      };
}

class UpdateManyCartAndReturnOutputType {
  const UpdateManyCartAndReturnOutputType({
    this.id,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory UpdateManyCartAndReturnOutputType.fromJson(Map json) =>
      UpdateManyCartAndReturnOutputType(
        id: json['id'],
        userId: json['userId'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
        user: json['user'] is Map ? _i1.User.fromJson(json['user']) : null,
      );

  final int? id;

  final int? userId;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final _i1.User? user;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'user': user?.toJson(),
      };
}

class CreateManyCartItemAndReturnOutputType {
  const CreateManyCartItemAndReturnOutputType({
    this.id,
    this.cartId,
    this.productId,
    this.quantity,
    this.priceAtAddition,
    this.addedAt,
    this.cart,
    this.product,
  });

  factory CreateManyCartItemAndReturnOutputType.fromJson(Map json) =>
      CreateManyCartItemAndReturnOutputType(
        id: json['id'],
        cartId: json['cartId'],
        productId: json['productId'],
        quantity: json['quantity'],
        priceAtAddition: json['priceAtAddition'],
        addedAt: switch (json['addedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['addedAt']
        },
        cart: json['cart'] is Map ? _i1.Cart.fromJson(json['cart']) : null,
        product: json['product'] is Map
            ? _i1.Product.fromJson(json['product'])
            : null,
      );

  final int? id;

  final int? cartId;

  final int? productId;

  final int? quantity;

  final _i3.Decimal? priceAtAddition;

  final DateTime? addedAt;

  final _i1.Cart? cart;

  final _i1.Product? product;

  Map<String, dynamic> toJson() => {
        'id': id,
        'cartId': cartId,
        'productId': productId,
        'quantity': quantity,
        'priceAtAddition': priceAtAddition,
        'addedAt': addedAt?.toIso8601String(),
        'cart': cart?.toJson(),
        'product': product?.toJson(),
      };
}

class UpdateManyCartItemAndReturnOutputType {
  const UpdateManyCartItemAndReturnOutputType({
    this.id,
    this.cartId,
    this.productId,
    this.quantity,
    this.priceAtAddition,
    this.addedAt,
    this.cart,
    this.product,
  });

  factory UpdateManyCartItemAndReturnOutputType.fromJson(Map json) =>
      UpdateManyCartItemAndReturnOutputType(
        id: json['id'],
        cartId: json['cartId'],
        productId: json['productId'],
        quantity: json['quantity'],
        priceAtAddition: json['priceAtAddition'],
        addedAt: switch (json['addedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['addedAt']
        },
        cart: json['cart'] is Map ? _i1.Cart.fromJson(json['cart']) : null,
        product: json['product'] is Map
            ? _i1.Product.fromJson(json['product'])
            : null,
      );

  final int? id;

  final int? cartId;

  final int? productId;

  final int? quantity;

  final _i3.Decimal? priceAtAddition;

  final DateTime? addedAt;

  final _i1.Cart? cart;

  final _i1.Product? product;

  Map<String, dynamic> toJson() => {
        'id': id,
        'cartId': cartId,
        'productId': productId,
        'quantity': quantity,
        'priceAtAddition': priceAtAddition,
        'addedAt': addedAt?.toIso8601String(),
        'cart': cart?.toJson(),
        'product': product?.toJson(),
      };
}

class CreateManyOrderAndReturnOutputType {
  const CreateManyOrderAndReturnOutputType({
    this.id,
    this.userId,
    this.shippingAddressId,
    this.billingAddressId,
    this.subtotal,
    this.tax,
    this.shippingCost,
    this.totalAmount,
    this.status,
    this.paymentStatus,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.shippingAddress,
    this.billingAddress,
  });

  factory CreateManyOrderAndReturnOutputType.fromJson(Map json) =>
      CreateManyOrderAndReturnOutputType(
        id: json['id'],
        userId: json['userId'],
        shippingAddressId: json['shippingAddressId'],
        billingAddressId: json['billingAddressId'],
        subtotal: json['subtotal'],
        tax: json['tax'],
        shippingCost: json['shippingCost'],
        totalAmount: json['totalAmount'],
        status: json['status'],
        paymentStatus: json['paymentStatus'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
        user: json['user'] is Map ? _i1.User.fromJson(json['user']) : null,
        shippingAddress: json['shippingAddress'] is Map
            ? _i1.Address.fromJson(json['shippingAddress'])
            : null,
        billingAddress: json['billingAddress'] is Map
            ? _i1.Address.fromJson(json['billingAddress'])
            : null,
      );

  final int? id;

  final int? userId;

  final int? shippingAddressId;

  final int? billingAddressId;

  final _i3.Decimal? subtotal;

  final _i3.Decimal? tax;

  final _i3.Decimal? shippingCost;

  final _i3.Decimal? totalAmount;

  final String? status;

  final String? paymentStatus;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final _i1.User? user;

  final _i1.Address? shippingAddress;

  final _i1.Address? billingAddress;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'shippingAddressId': shippingAddressId,
        'billingAddressId': billingAddressId,
        'subtotal': subtotal,
        'tax': tax,
        'shippingCost': shippingCost,
        'totalAmount': totalAmount,
        'status': status,
        'paymentStatus': paymentStatus,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'user': user?.toJson(),
        'shippingAddress': shippingAddress?.toJson(),
        'billingAddress': billingAddress?.toJson(),
      };
}

class UpdateManyOrderAndReturnOutputType {
  const UpdateManyOrderAndReturnOutputType({
    this.id,
    this.userId,
    this.shippingAddressId,
    this.billingAddressId,
    this.subtotal,
    this.tax,
    this.shippingCost,
    this.totalAmount,
    this.status,
    this.paymentStatus,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.shippingAddress,
    this.billingAddress,
  });

  factory UpdateManyOrderAndReturnOutputType.fromJson(Map json) =>
      UpdateManyOrderAndReturnOutputType(
        id: json['id'],
        userId: json['userId'],
        shippingAddressId: json['shippingAddressId'],
        billingAddressId: json['billingAddressId'],
        subtotal: json['subtotal'],
        tax: json['tax'],
        shippingCost: json['shippingCost'],
        totalAmount: json['totalAmount'],
        status: json['status'],
        paymentStatus: json['paymentStatus'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
        user: json['user'] is Map ? _i1.User.fromJson(json['user']) : null,
        shippingAddress: json['shippingAddress'] is Map
            ? _i1.Address.fromJson(json['shippingAddress'])
            : null,
        billingAddress: json['billingAddress'] is Map
            ? _i1.Address.fromJson(json['billingAddress'])
            : null,
      );

  final int? id;

  final int? userId;

  final int? shippingAddressId;

  final int? billingAddressId;

  final _i3.Decimal? subtotal;

  final _i3.Decimal? tax;

  final _i3.Decimal? shippingCost;

  final _i3.Decimal? totalAmount;

  final String? status;

  final String? paymentStatus;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final _i1.User? user;

  final _i1.Address? shippingAddress;

  final _i1.Address? billingAddress;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'shippingAddressId': shippingAddressId,
        'billingAddressId': billingAddressId,
        'subtotal': subtotal,
        'tax': tax,
        'shippingCost': shippingCost,
        'totalAmount': totalAmount,
        'status': status,
        'paymentStatus': paymentStatus,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'user': user?.toJson(),
        'shippingAddress': shippingAddress?.toJson(),
        'billingAddress': billingAddress?.toJson(),
      };
}

class CreateManyOrderItemAndReturnOutputType {
  const CreateManyOrderItemAndReturnOutputType({
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.priceAtPurchase,
    this.subtotal,
    this.createdAt,
    this.order,
    this.product,
  });

  factory CreateManyOrderItemAndReturnOutputType.fromJson(Map json) =>
      CreateManyOrderItemAndReturnOutputType(
        id: json['id'],
        orderId: json['orderId'],
        productId: json['productId'],
        quantity: json['quantity'],
        priceAtPurchase: json['priceAtPurchase'],
        subtotal: json['subtotal'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        order: json['order'] is Map ? _i1.Order.fromJson(json['order']) : null,
        product: json['product'] is Map
            ? _i1.Product.fromJson(json['product'])
            : null,
      );

  final int? id;

  final int? orderId;

  final int? productId;

  final int? quantity;

  final _i3.Decimal? priceAtPurchase;

  final _i3.Decimal? subtotal;

  final DateTime? createdAt;

  final _i1.Order? order;

  final _i1.Product? product;

  Map<String, dynamic> toJson() => {
        'id': id,
        'orderId': orderId,
        'productId': productId,
        'quantity': quantity,
        'priceAtPurchase': priceAtPurchase,
        'subtotal': subtotal,
        'createdAt': createdAt?.toIso8601String(),
        'order': order?.toJson(),
        'product': product?.toJson(),
      };
}

class UpdateManyOrderItemAndReturnOutputType {
  const UpdateManyOrderItemAndReturnOutputType({
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.priceAtPurchase,
    this.subtotal,
    this.createdAt,
    this.order,
    this.product,
  });

  factory UpdateManyOrderItemAndReturnOutputType.fromJson(Map json) =>
      UpdateManyOrderItemAndReturnOutputType(
        id: json['id'],
        orderId: json['orderId'],
        productId: json['productId'],
        quantity: json['quantity'],
        priceAtPurchase: json['priceAtPurchase'],
        subtotal: json['subtotal'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        order: json['order'] is Map ? _i1.Order.fromJson(json['order']) : null,
        product: json['product'] is Map
            ? _i1.Product.fromJson(json['product'])
            : null,
      );

  final int? id;

  final int? orderId;

  final int? productId;

  final int? quantity;

  final _i3.Decimal? priceAtPurchase;

  final _i3.Decimal? subtotal;

  final DateTime? createdAt;

  final _i1.Order? order;

  final _i1.Product? product;

  Map<String, dynamic> toJson() => {
        'id': id,
        'orderId': orderId,
        'productId': productId,
        'quantity': quantity,
        'priceAtPurchase': priceAtPurchase,
        'subtotal': subtotal,
        'createdAt': createdAt?.toIso8601String(),
        'order': order?.toJson(),
        'product': product?.toJson(),
      };
}

class CreateManyPaymentAndReturnOutputType {
  const CreateManyPaymentAndReturnOutputType({
    this.id,
    this.orderId,
    this.paymentMethod,
    this.transactionId,
    this.amount,
    this.status,
    this.paymentDate,
    this.order,
  });

  factory CreateManyPaymentAndReturnOutputType.fromJson(Map json) =>
      CreateManyPaymentAndReturnOutputType(
        id: json['id'],
        orderId: json['orderId'],
        paymentMethod: json['paymentMethod'],
        transactionId: json['transactionId'],
        amount: json['amount'],
        status: json['status'],
        paymentDate: switch (json['paymentDate']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['paymentDate']
        },
        order: json['order'] is Map ? _i1.Order.fromJson(json['order']) : null,
      );

  final int? id;

  final int? orderId;

  final String? paymentMethod;

  final String? transactionId;

  final _i3.Decimal? amount;

  final String? status;

  final DateTime? paymentDate;

  final _i1.Order? order;

  Map<String, dynamic> toJson() => {
        'id': id,
        'orderId': orderId,
        'paymentMethod': paymentMethod,
        'transactionId': transactionId,
        'amount': amount,
        'status': status,
        'paymentDate': paymentDate?.toIso8601String(),
        'order': order?.toJson(),
      };
}

class UpdateManyPaymentAndReturnOutputType {
  const UpdateManyPaymentAndReturnOutputType({
    this.id,
    this.orderId,
    this.paymentMethod,
    this.transactionId,
    this.amount,
    this.status,
    this.paymentDate,
    this.order,
  });

  factory UpdateManyPaymentAndReturnOutputType.fromJson(Map json) =>
      UpdateManyPaymentAndReturnOutputType(
        id: json['id'],
        orderId: json['orderId'],
        paymentMethod: json['paymentMethod'],
        transactionId: json['transactionId'],
        amount: json['amount'],
        status: json['status'],
        paymentDate: switch (json['paymentDate']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['paymentDate']
        },
        order: json['order'] is Map ? _i1.Order.fromJson(json['order']) : null,
      );

  final int? id;

  final int? orderId;

  final String? paymentMethod;

  final String? transactionId;

  final _i3.Decimal? amount;

  final String? status;

  final DateTime? paymentDate;

  final _i1.Order? order;

  Map<String, dynamic> toJson() => {
        'id': id,
        'orderId': orderId,
        'paymentMethod': paymentMethod,
        'transactionId': transactionId,
        'amount': amount,
        'status': status,
        'paymentDate': paymentDate?.toIso8601String(),
        'order': order?.toJson(),
      };
}

class CreateManyReviewAndReturnOutputType {
  const CreateManyReviewAndReturnOutputType({
    this.id,
    this.productId,
    this.userId,
    this.rating,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.user,
  });

  factory CreateManyReviewAndReturnOutputType.fromJson(Map json) =>
      CreateManyReviewAndReturnOutputType(
        id: json['id'],
        productId: json['productId'],
        userId: json['userId'],
        rating: json['rating'],
        comment: json['comment'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
        product: json['product'] is Map
            ? _i1.Product.fromJson(json['product'])
            : null,
        user: json['user'] is Map ? _i1.User.fromJson(json['user']) : null,
      );

  final int? id;

  final int? productId;

  final int? userId;

  final int? rating;

  final String? comment;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final _i1.Product? product;

  final _i1.User? user;

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'userId': userId,
        'rating': rating,
        'comment': comment,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'product': product?.toJson(),
        'user': user?.toJson(),
      };
}

class UpdateManyReviewAndReturnOutputType {
  const UpdateManyReviewAndReturnOutputType({
    this.id,
    this.productId,
    this.userId,
    this.rating,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.user,
  });

  factory UpdateManyReviewAndReturnOutputType.fromJson(Map json) =>
      UpdateManyReviewAndReturnOutputType(
        id: json['id'],
        productId: json['productId'],
        userId: json['userId'],
        rating: json['rating'],
        comment: json['comment'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
        product: json['product'] is Map
            ? _i1.Product.fromJson(json['product'])
            : null,
        user: json['user'] is Map ? _i1.User.fromJson(json['user']) : null,
      );

  final int? id;

  final int? productId;

  final int? userId;

  final int? rating;

  final String? comment;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final _i1.Product? product;

  final _i1.User? user;

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'userId': userId,
        'rating': rating,
        'comment': comment,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'product': product?.toJson(),
        'user': user?.toJson(),
      };
}

class CreateManyWishlistAndReturnOutputType {
  const CreateManyWishlistAndReturnOutputType({
    this.id,
    this.userId,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory CreateManyWishlistAndReturnOutputType.fromJson(Map json) =>
      CreateManyWishlistAndReturnOutputType(
        id: json['id'],
        userId: json['userId'],
        name: json['name'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
        user: json['user'] is Map ? _i1.User.fromJson(json['user']) : null,
      );

  final int? id;

  final int? userId;

  final String? name;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final _i1.User? user;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'name': name,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'user': user?.toJson(),
      };
}

class UpdateManyWishlistAndReturnOutputType {
  const UpdateManyWishlistAndReturnOutputType({
    this.id,
    this.userId,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory UpdateManyWishlistAndReturnOutputType.fromJson(Map json) =>
      UpdateManyWishlistAndReturnOutputType(
        id: json['id'],
        userId: json['userId'],
        name: json['name'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
        user: json['user'] is Map ? _i1.User.fromJson(json['user']) : null,
      );

  final int? id;

  final int? userId;

  final String? name;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final _i1.User? user;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'name': name,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'user': user?.toJson(),
      };
}

class CreateManyWishlistItemAndReturnOutputType {
  const CreateManyWishlistItemAndReturnOutputType({
    this.wishlistId,
    this.productId,
    this.addedAt,
    this.wishlist,
    this.product,
  });

  factory CreateManyWishlistItemAndReturnOutputType.fromJson(Map json) =>
      CreateManyWishlistItemAndReturnOutputType(
        wishlistId: json['wishlistId'],
        productId: json['productId'],
        addedAt: switch (json['addedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['addedAt']
        },
        wishlist: json['wishlist'] is Map
            ? _i1.Wishlist.fromJson(json['wishlist'])
            : null,
        product: json['product'] is Map
            ? _i1.Product.fromJson(json['product'])
            : null,
      );

  final int? wishlistId;

  final int? productId;

  final DateTime? addedAt;

  final _i1.Wishlist? wishlist;

  final _i1.Product? product;

  Map<String, dynamic> toJson() => {
        'wishlistId': wishlistId,
        'productId': productId,
        'addedAt': addedAt?.toIso8601String(),
        'wishlist': wishlist?.toJson(),
        'product': product?.toJson(),
      };
}

class UpdateManyWishlistItemAndReturnOutputType {
  const UpdateManyWishlistItemAndReturnOutputType({
    this.wishlistId,
    this.productId,
    this.addedAt,
    this.wishlist,
    this.product,
  });

  factory UpdateManyWishlistItemAndReturnOutputType.fromJson(Map json) =>
      UpdateManyWishlistItemAndReturnOutputType(
        wishlistId: json['wishlistId'],
        productId: json['productId'],
        addedAt: switch (json['addedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['addedAt']
        },
        wishlist: json['wishlist'] is Map
            ? _i1.Wishlist.fromJson(json['wishlist'])
            : null,
        product: json['product'] is Map
            ? _i1.Product.fromJson(json['product'])
            : null,
      );

  final int? wishlistId;

  final int? productId;

  final DateTime? addedAt;

  final _i1.Wishlist? wishlist;

  final _i1.Product? product;

  Map<String, dynamic> toJson() => {
        'wishlistId': wishlistId,
        'productId': productId,
        'addedAt': addedAt?.toIso8601String(),
        'wishlist': wishlist?.toJson(),
        'product': product?.toJson(),
      };
}

class CreateManyDiscountAndReturnOutputType {
  const CreateManyDiscountAndReturnOutputType({
    this.id,
    this.code,
    this.description,
    this.amount,
    this.discountType,
    this.usageLimit,
    this.timesUsed,
    this.validFrom,
    this.validTo,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory CreateManyDiscountAndReturnOutputType.fromJson(Map json) =>
      CreateManyDiscountAndReturnOutputType(
        id: json['id'],
        code: json['code'],
        description: json['description'],
        amount: json['amount'],
        discountType: json['discountType'],
        usageLimit: json['usageLimit'],
        timesUsed: json['timesUsed'],
        validFrom: switch (json['validFrom']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['validFrom']
        },
        validTo: switch (json['validTo']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['validTo']
        },
        isActive: json['isActive'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
      );

  final int? id;

  final String? code;

  final String? description;

  final _i3.Decimal? amount;

  final String? discountType;

  final int? usageLimit;

  final int? timesUsed;

  final DateTime? validFrom;

  final DateTime? validTo;

  final bool? isActive;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'description': description,
        'amount': amount,
        'discountType': discountType,
        'usageLimit': usageLimit,
        'timesUsed': timesUsed,
        'validFrom': validFrom?.toIso8601String(),
        'validTo': validTo?.toIso8601String(),
        'isActive': isActive,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}

class UpdateManyDiscountAndReturnOutputType {
  const UpdateManyDiscountAndReturnOutputType({
    this.id,
    this.code,
    this.description,
    this.amount,
    this.discountType,
    this.usageLimit,
    this.timesUsed,
    this.validFrom,
    this.validTo,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory UpdateManyDiscountAndReturnOutputType.fromJson(Map json) =>
      UpdateManyDiscountAndReturnOutputType(
        id: json['id'],
        code: json['code'],
        description: json['description'],
        amount: json['amount'],
        discountType: json['discountType'],
        usageLimit: json['usageLimit'],
        timesUsed: json['timesUsed'],
        validFrom: switch (json['validFrom']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['validFrom']
        },
        validTo: switch (json['validTo']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['validTo']
        },
        isActive: json['isActive'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
      );

  final int? id;

  final String? code;

  final String? description;

  final _i3.Decimal? amount;

  final String? discountType;

  final int? usageLimit;

  final int? timesUsed;

  final DateTime? validFrom;

  final DateTime? validTo;

  final bool? isActive;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'description': description,
        'amount': amount,
        'discountType': discountType,
        'usageLimit': usageLimit,
        'timesUsed': timesUsed,
        'validFrom': validFrom?.toIso8601String(),
        'validTo': validTo?.toIso8601String(),
        'isActive': isActive,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}

class CreateManyProductDiscountAndReturnOutputType {
  const CreateManyProductDiscountAndReturnOutputType({
    this.productId,
    this.discountId,
    this.product,
    this.discount,
  });

  factory CreateManyProductDiscountAndReturnOutputType.fromJson(Map json) =>
      CreateManyProductDiscountAndReturnOutputType(
        productId: json['productId'],
        discountId: json['discountId'],
        product: json['product'] is Map
            ? _i1.Product.fromJson(json['product'])
            : null,
        discount: json['discount'] is Map
            ? _i1.Discount.fromJson(json['discount'])
            : null,
      );

  final int? productId;

  final int? discountId;

  final _i1.Product? product;

  final _i1.Discount? discount;

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'discountId': discountId,
        'product': product?.toJson(),
        'discount': discount?.toJson(),
      };
}

class UpdateManyProductDiscountAndReturnOutputType {
  const UpdateManyProductDiscountAndReturnOutputType({
    this.productId,
    this.discountId,
    this.product,
    this.discount,
  });

  factory UpdateManyProductDiscountAndReturnOutputType.fromJson(Map json) =>
      UpdateManyProductDiscountAndReturnOutputType(
        productId: json['productId'],
        discountId: json['discountId'],
        product: json['product'] is Map
            ? _i1.Product.fromJson(json['product'])
            : null,
        discount: json['discount'] is Map
            ? _i1.Discount.fromJson(json['discount'])
            : null,
      );

  final int? productId;

  final int? discountId;

  final _i1.Product? product;

  final _i1.Discount? discount;

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'discountId': discountId,
        'product': product?.toJson(),
        'discount': discount?.toJson(),
      };
}
